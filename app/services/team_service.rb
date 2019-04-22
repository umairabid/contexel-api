class TeamService

  def create_team(params)
    team = Team.new
    team.manager_id = params[:manager_id]
    populate_team team, params
    team.save!
    team
  end

  def update_team(team, params)
    populate_team team, params
    team.save!
    team
  end

  def populate_team(team, params)
    team.name = params[:name]
    team.description = params[:description]
  end

end