require_relative 'stats'

class SeasonStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def most_tackles(season_param)
    season_games = @game_teams.select do |game_team|
      require "pry"; binding.pry
      # look into changing game_id and season back to strings
      (game_team.game_id/1000000).to_s == season_param[0..3]
    end
    team_with_most = season_games.max_by { |team| team.tackles }
    find_name(team_with_most.team_id)
  end

  def fewest_tackles(season)
     team_with_fewest = @game_teams.min_by { |team| team.tackles }
    find_name(team_with_fewest.team_id)
  end
end
