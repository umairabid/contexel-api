class PublishingPlatformService



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

end
