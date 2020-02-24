require_relative 'stats'

class SeasonStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def winningest_coach(season_param)
    season_games = @game_teams.select do |game_team|
      # look into changing game_id and season back to strings
      (game_team.game_id/1000000).to_s == season_param[0..3]
    end

    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }

    season_games.each do |season_game|
      if season_game.result == "WIN"
        win_ratios[season_game.head_coach][0] += 1
      end
      win_ratios[season_game.head_coach][1] += 1
    end

    win_percentages = win_ratios.merge(win_ratios) do |k, v|
      v.first.fdiv(v.last)
    end

    win_percentages.key(win_percentages.values.max)
  end
end
