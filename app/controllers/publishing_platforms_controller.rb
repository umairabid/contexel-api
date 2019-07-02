class PublishingPlatformsController < ApplicationController
  authorize_resource

  before_action :set_service
  before_action :set_platform, only: [:destroy]

  def index
    render json: current_user.profile.publishing_platforms
  end

  def create
    platform = @service.create_platform params[:platform], current_user
    render json: platform
  end

  def destroy
    @platform.destroy
    render json: {status: "removed"}
  end

  private

  def set_service
    @service = PublishingPlatformService.new
  end

  def set_platform
    @platform = PublishingPlatform.find(params[:id])
  end

end
