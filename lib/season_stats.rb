require_relative 'stats'
require 'pry'
class SeasonStats < Stats

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def shot_accuracy_by_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f/total_shots_by_team_id(team_id) * 100.0)
    .round(2)
  end

  def biggest_bust(season_id)
    biggest = difference_percentage(season_id)
    value = biggest.values.max
    find_name(biggest.key(value))
  end

  def biggest_surprise(season_id)
    biggest = difference_percentage(season_id)
    value = biggest.values.min
    find_name(biggest.key(value))
  end

  def difference_percentage(season_id)
    list_of_games = games.find_all { |game| game.season == season_id}
    postseason = list_of_games.find_all {|season| season.type == 'Postseason'}
    regularseason = list_of_games.find_all {|season| season.type == 'Regular Season'}
    wins_hash_reg = {}
    wins_hash_post = {}
    post_percent = {}
    reg_percent = {}
    calculate_wins(regularseason, wins_hash_reg)
    calculate_wins(postseason, wins_hash_post)
    calculate_percent(wins_hash_post, post_percent)
    calculate_percent(wins_hash_reg, reg_percent)
    difference_seasons(reg_percent, post_percent)
  end

  def difference_seasons(wins_hash_reg, wins_hash_post)
    team = {}
    wins_hash_reg.each_key do |id|
      if wins_hash_reg[id] == nil || wins_hash_post[id] == nil
        team[id] = wins_hash_reg[id]
      else
        team[id] = wins_hash_reg[id] - wins_hash_post[id]
      end
    end
    team
  end

  def calculate_percent(hash_params, hash_percent)
    hash_params.each_key do |team|
      hash_percent[team] = hash_params[team][0].to_f / hash_params[team][1].to_f
    end
  end

  def check_empty(away, home, wins_hash)
    if wins_hash[away] == nil
      wins_hash[away] = [0,0]
    end
    if wins_hash[home] == nil
      wins_hash[home] = [0,0]
    end
    wins_hash[home][1] += 1
    wins_hash[away][1] += 1
  end

  def calculate_wins(array_games, wins_hash)
    array_games.each do |game|
      if game.away_goals > game.home_goals
        check_empty(game.away_team_id, game.home_team_id, wins_hash)
        wins_hash[game.away_team_id][0] += 1
      elsif game.away_goals < game.home_goals
        check_empty(game.away_team_id, game.home_team_id, wins_hash)
        wins_hash[game.home_team_id][0] += 1
      else
        check_empty(game.away_team_id, game.home_team_id, wins_hash)
      end
    end
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

end
