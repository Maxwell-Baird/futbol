require_relative 'stats'

class TeamStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def check(hash, key, game)
    if hash[key] == nil
      hash[key] = [0,0]
    end
    if key >= game
      hash[key][1] += 1
    else
      hash[key][0] += 1
      hash[key][1] += 1
    end
  end

  def head_to_head(team_id)
    all_games = games.find_all{ |game| team_id == game.away_team_id || team_id == game.home_team_id}
    a_hash = {}
    all_games.each do |game|
      if team_id == game.away_team_id
        check(a_hash, game.home_team_id, game.away_team_id)
      else
        check(a_hash, game.away_team_id, game.home_team_id)
      end
    end
    a_hash
  end
end
