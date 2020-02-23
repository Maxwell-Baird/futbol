require_relative 'stats'

class SeasonStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def most_tackles
     team_with_most = @game_teams.max_by { |team| team.tackles }
    find_name(team_with_most.team_id)
  end

  def fewest_tackles
     team_with_fewest = @game_teams.min_by { |team| team.tackles }
    find_name(team_with_fewest.team_id)
  end

#Helper Method
#We tend to use this one a lot
  def find_name(id)
    team = @teams.find { |team| team.team_id == id }
    team.teamname
  end
end
