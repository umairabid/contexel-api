require 'uri'

class PublishingPlatformService

  def publish(params)
    submission = TaskSubmission.find(params[:submission_id])
    platform = PublishingPlatform.find(params[:platform_id])
    raise "Submission does exist" unless submission
    self.send("publish_with_#{platform.name}", submission, platform)
  end

  def publish_with_wordpress(submission, platform)
    post_id = publish_wordpress(submission, platform)
    save_publication(submission, platform, "#{platform.url}?p=#{post_id}")
  end

  def publish_with_facebook(submission, platform)
    id = publish_facebook(submission, platform)
    ids = id.split("_")
    post_url = "https://www.facebook.com/permalink.php?story_fbid=#{ids[1]}&id=#{ids[0]}"
    save_publication(submission, platform, post_url)
  end

  def save_publication(submission, platform, url)
    publication = TaskPublication.new
    publication.publishing_platform = platform
    publication.task_submission = submission
    publication.link = url
    publication.save!
    publication
  end

  def publish_wordpress(submission, platform)
    wp_client = connect_with_wordpress(platform.url, platform.username, platform.password)
    wp_client.newPost( :blog_id => 0, # 0 unless using WP Multi-Site, then use the blog id
      :content => {
          :post_status  => "publish",
          :post_content => submission.submission,
          :post_title   => submission.title,
          :post_author  => 1
      }
    )
  end

  def publish_facebook(submission, platform)
    user_graph = Koala::Facebook::API.new(platform.token)
    pages = user_graph.get_connections('me', 'accounts')
    page_token = pages.first['access_token']
    page_graph = Koala::Facebook::API.new(page_token)
    submission_content = ActionController::Base.helpers.strip_tags(submission.submission)
    post = page_graph.put_wall_post(submission_content)
    post["id"]
  end

  def create_platform(params, user)
    platform = PublishingPlatform.defined_enums["name"][params[:type]]
    raise "UndefinedPlatform" unless platform
    self.send("create_#{params[:type]}", params, user)
  end

  def connect_with_wordpress(url, username, password)
    options = wp_url_options(url)
    begin
      wp = Rubypress::Client.new(:host => options[:host],
                                 :port => options[:port],
                                 :path => options[:path],
                                 :username => username,
                                 :use_ssl => options[:use_ssl],
                                 :password => password)
      wp.getOptions
      return wp
    rescue
      raise 'Unable to connect with wordpress'
    end
  end

  private

  def create_wordpress(params, user)
    connect_with_wordpress(params[:url], params[:username], params[:password])
    platform = PublishingPlatform.new
    platform.name = PublishingPlatform::WORDPRESS
    platform.url = params[:url]
    platform.username = params[:username]
    platform.password = params[:password]
    platform.manager = user.profile
    platform.save!
    platform
  end

  def create_facebook(params, user)
    platform = PublishingPlatform.new
    platform.name = PublishingPlatform::FACEBOOK
    platform.username = params[:username]
    platform.token = params[:token]
    platform.manager = user.profile
    platform.password = 'gibbrish'
    platform.url = 'facebook.com'
    platform.save!
    platform
  end

  def wp_url_options(url)
    uri = URI.parse url
    {
        host: uri.host,
        path: uri.path ? "#{uri.path}/xmlrpc.php" : "/xmlrpc.php",
        use_ssl: uri.scheme != "http",
        port: uri.port
    }
  end

end
