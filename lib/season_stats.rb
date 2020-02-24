require_relative 'stats'
require 'pry'
class SeasonStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def biggest_bust(season_id)
    biggest = difference_percentage(season_id, 'b')
    value = biggest.values.max
    find_name(biggest.key(value))
  end

  def biggest_surprise(season_id)
    biggest = difference_percentage(season_id, 's')
    value = biggest.values.min
    find_name(biggest.key(value))
  end

  def difference_percentage(season_id, biggest)
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

    difference_seasons(reg_percent, post_percent, biggest)
  end

  def difference_seasons(wins_hash_reg, wins_hash_post, biggest)
    team = {}
    wins_hash_reg.each_key do |id|
      if (wins_hash_reg[id] == nil || wins_hash_post[id] == nil) && biggest == 's'
        team[id] = 0
      elsif (wins_hash_reg[id] == nil || wins_hash_post[id] == nil) && biggest == 'b'
        team[id] = -99
      elsif biggest == 'b'
        team[id] = wins_hash_reg[id] - wins_hash_post[id]
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
  end

  def calculate_wins(array_games, wins_hash)
    array_games.each do |game|
      if game.away_goals > game.home_goals
        check_empty(game.away_team_id, game.home_team_id, wins_hash)
        wins_hash[game.away_team_id][1] += 1
        wins_hash[game.away_team_id][0] += 1
        wins_hash[game.home_team_id][1] += 1
      elsif game.away_goals < game.home_goals
        check_empty(game.away_team_id, game.home_team_id, wins_hash)
        wins_hash[game.home_team_id][1] += 1
        wins_hash[game.home_team_id][0] += 1
        wins_hash[game.away_team_id][1] += 1
        end
    end
  end
end
