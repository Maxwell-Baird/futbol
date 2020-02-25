require_relative 'stats'

class TeamStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def head_to_head(team_id)
    all_games = games.find_all{ |game| team_id == game.away_team_id || team_id == game.home_team_id}
  end
end
