class WritersController < ApplicationController

  load_and_authorize_resource

  def index
    render json: Writer.all
  end

end