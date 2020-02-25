require_relative 'stats'

class SeasonStats < Stats

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def most_accurate_team(season_id)
    find_name(shots_and_goals_per_team(season_id).max_by { |team, ratio| ratio}.first)
  end

  def least_accurate_team(season_id)
    find_name(shots_and_goals_per_team(season_id).min_by { |team, ratio| ratio}.first)
  end

  def most_tackles(season_param)
    season_games = season_game_teams(season_param).max_by { |team| team.tackles }
    find_name(season_games.team_id)
  end

  def fewest_tackles(season_param)
    season_games = season_game_teams(season_param).min_by { |team| team.tackles }
    find_name(season_games.team_id)
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

  #helper methods
  def shots_and_goals_per_team(season_id)
    team_accuracy = {}
    team_shots = Hash.new(0)
    team_goals = Hash.new(0)
    season_game_teams(season_id).each do |game|
      team_shots[game.team_id] += game.shots
      team_goals[game.team_id] += game.goals
    end
    team_goals.each do |team, goals|
      team_accuracy[team] = (goals.to_f / team_shots[team])
    end
    team_accuracy
  end
end
