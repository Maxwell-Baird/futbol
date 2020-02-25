require_relative 'stats'

class SeasonStats < Stats

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end
<<<<<<< HEAD

=======
  
>>>>>>> 007fd85e3c70889f308ab3e6572f9e6050e44f36
  def shot_accuracy_by_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f/total_shots_by_team_id(team_id) * 100.0)
    .round(2)
  end

  def winningest_coach(season_param)
    season_games = season_game_teams(season_param)

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

  def worst_coach(season_param)
    season_games = season_game_teams(season_param)

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

    win_percentages.key(win_percentages.values.min)
  end

end
