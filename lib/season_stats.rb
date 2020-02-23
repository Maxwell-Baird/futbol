require_relative 'stats'

class SeasonStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def most_accurate_team(season_id)
    # Name of the Team with the best ratio of shots to goals for the season	String
  end

  def least_accurate_team(season_id)
    # Name of the Team with the worst ratio of shots to goals for the season
  end
end
