class TaskSubmissionsController < ApplicationController
  authorize_resource

  def create
    render json: {name: "hello"}
  end
end
