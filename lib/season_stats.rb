require_relative 'stats'

class SeasonStats < Stats

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def shot_accuracy_by_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f/total_shots_by_team_id(team_id) * 100.0)
    .round(2)
  end

  def most_tackles(season_param)
    # total_tackles = {}
    total_tackles = season_game_teams(season_param).reduce(Hash.new(0)) do |total_tackles, game_team|
      total_tackles[game_team.team_id] += game_team.tackles
      total_tackles
    end
    team_id = total_tackles.key(total_tackles.values.max)
    find_name(team_id)
  end

  def fewest_tackles(season_param)
    total_tackles = season_game_teams(season_param).reduce(Hash.new(0)) do |total_tackles, game_team|
      total_tackles[game_team.team_id] += game_team.tackles
      total_tackles
    end
    team_id = total_tackles.key(total_tackles.values.min)
    find_name(team_id)
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
