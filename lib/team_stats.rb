require_relative 'stats'
require 'pry'

class TeamStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def favorite_opponent(team_id)
    games_with_team = @games.select do |game|
      game.away_team_id == team_id.to_i || game.home_team_id == team_id.to_i
    end

    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }
    games_with_team.each do |game|
      if game.away_goals > game.home_goals
        win_ratios[game.away_team_id][0] += 1
      end
      if game.home_goals > game.away_goals
        win_ratios[game.home_team_id][0] += 1
      end
      win_ratios[game.away_team_id][1] += 1
      win_ratios[game.home_team_id][1] += 1
    end
    win_percentages = win_ratios.each_with_object(Hash.new) do |(team_id, win_ratio), win_percent|
      win_percent[team_id] = win_ratio[0].fdiv(win_ratio[1]) * 100
    end
    team_id = win_percentages.key(win_percentages.values.min)
    find_name(team_id)
  end

  def rival(team_id)
    games_with_team = @games.select do |game|
      game.away_team_id == team_id.to_i || game.home_team_id == team_id.to_i
    end
    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }
    games_with_team.each do |game|
      if game.away_goals > game.home_goals
        win_ratios[game.away_team_id][0] += 1
      end
      if game.home_goals > game.away_goals
        win_ratios[game.home_team_id][0] += 1
      end
      win_ratios[game.away_team_id][1] += 1
      win_ratios[game.home_team_id][1] += 1
    end
    win_percentages = win_ratios.each_with_object(Hash.new) do |(team_id, win_ratio), win_percent|
      win_percent[team_id] = win_ratio[0].fdiv(win_ratio[1]) * 100
    end
    team_id = win_percentages.key(win_percentages.values.max)
    find_name(team_id)
  end

  def biggest_team_blowout(team_id)
    wins_as_home = @games.select do |game|
      game.home_team_id == team_id.to_i &&
      game.home_goals > game.away_goals
    end
    home_blowout_game = wins_as_home.max_by do |game|
      game.home_goals - game.away_goals
    end
    home_blowout = home_blowout_game.home_goals - home_blowout_game.away_goals
    wins_as_away_team = @games.select do |game|
      game.away_team_id == team_id.to_i &&
      game.away_goals > game.home_goals
    end
    away_blowout_game = wins_as_away_team.max_by do |game|
      game.away_goals - game.home_goals
    end
    away_blowout = away_blowout_game.away_goals - away_blowout_game.home_goals
    [away_blowout, home_blowout].max
  end

  def most_goals_scored(team_id)
    most = 0
    games.each do |game|
      if team_id == game.home_team_id
        if game.home_goals > most
          most = game.home_goals
        end
      else
        if game.away_goals > most
          most = game.away_goals
        end end end
    most
  end

  def fewest_goals_scored(team_id)
    few = 0
    games.each do |game|
      if team_id == game.home_team_id
        if game.home_goals < few
          few = game.home_goals
        end
      else
        if game.away_goals < few
          few = game.away_goals
        end end end
    few
  end

  def count_wins(game, seasons, team_id)
    if game.home_team_id == team_id.to_i
      check_empty(game, seasons)
      seasons[game.season][1] += 1
      if  game.home_goals > game.away_goals
        seasons[game.season][0] += 1
      end
    elsif game.away_team_id == team_id.to_i
      check_empty(game, seasons)
      seasons[game.season][1] += 1
      if  game.away_goals > game.home_goals
        seasons[game.season][0] += 1
      end
    end
  end

  def check_empty(game, seasons)
    if seasons[game.season] == nil
      seasons[game.season] = [0,0]
    end
  end

  def win_percentage_per_season(team_id)
    seasons = {}
    games.each do |game|
      count_wins(game, seasons, team_id)
    end
    per_season = {}
    seasons.each_key do |key|
      per_season[key] = seasons[key][0].to_f/seasons[key][1].to_f
    end
    per_season
  end

  def best_season(team_id)
    hash = win_percentage_per_season(team_id)
    best = hash.values.max
    hash.key(best)
  end

  def worst_season(team_id)
    hash = win_percentage_per_season(team_id)
    best = hash.values.min
    hash.key(best)
  end

  def average_win_percentage(team_id)
    hash = win_percentage_per_season(team_id)
    best = (hash.values.sum / hash.length).round(2)
  end
end
