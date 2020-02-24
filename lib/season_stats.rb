require_relative 'stats'

class SeasonStats < Stats

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def shot_accuracy_by_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f/total_shots_by_team_id(team_id) * 100.0)
    .round(2)
  end

  def most_accurate_team(season_id)
    #within season find the team with best shot accuracy
  end
  # def least_accurate_team(season_id)
  #   # Name of the Team with the worst ratio of shots to goals for the season
  # end


#   def shot_accuracy_by_team_id(team_id)
#     (total_goals_by_team_id(team_id).to_f/total_shots_by_team_id(team_id) * 100.0)
#     .floor
#   end
end
