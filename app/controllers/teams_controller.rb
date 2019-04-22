class TeamsController < ApplicationController

  authorize_resource

  before_action :set_service
  before_action :set_team, only: [:update, :destroy]

  def index
    render json: Team.all
  end

  def create
    params[:team][:manager_id] = current_user.profile.id
    team = @service.create_team params[:team]
    render json: team
  end

  def update
    team = @service.update_team @team, params[:team]
    render json: team
  end

  def destroy
    @team.destroy
    render json: {status: "removed"}
  end

  private

  def set_service
    @service = TeamService.new
  end

  def set_team
    @team = Team.find(params[:id])
  end

end
