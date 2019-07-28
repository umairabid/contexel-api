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
          #:post_date    => Time.now,
          :post_content => submission.submission,
          :post_title   => submission.title,
          #:post_name    => "/rubypress-is-the-best",
          :post_author  => 1, # 1 if there is only the admin user, otherwise the user's id
      }
    )
  end

  def create_platform(params, user)
    platform = PublishingPlatform.defined_enums["name"][params[:type]]
    raise "UndefinedPlatform" unless platform
    self.send("create_#{params[:type]}", params, user)
  end

  def connect_with_wordpress(url, username, password)
    begin
      wp = Rubypress::Client.new(:host => url,
                                 :port => "80",
                                 :path => "/wordpress/xmlrpc.php",
                                 :username => username,
                                 :use_ssl => false,
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

end
