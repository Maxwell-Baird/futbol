require_relative 'stats'

class LeagueStats < Stats

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def best_offense
    find_name(unique_team_ids.max_by { |team_id| average_goals_per_team(team_id) })
  end

  def worst_offense
    find_name(unique_team_ids.min_by { |team_id| average_goals_per_team(team_id) })
  end

  def best_defense
     find_name(defense_helper.max_by { |id, goals| goals }.first)
  end

  def worst_defense
    find_name(defense_helper.min_by { |id, goals| goals }.first)
  end

  def lowest_scoring_visitor
    scoring('away','low') end

  def lowest_scoring_home_team
    scoring('home','low') end

  def highest_scoring_visitor
    scoring('away','win') end

  def highest_scoring_home_team
    scoring('home','win') end

  def winningest_team
    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }
    @games.each do |game|
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
    find_name(win_percentages.key(win_percentages.values.max))
  end

  def best_fans
    find_name(percent_differences.key(percent_differences.values.max).to_i)
  end

  def worst_fans
    team_names = []
    percent_differences.each do |team_id, percent_difference|
      if percent_difference < 0
        team_names << find_name(team_id) end
    end
    team_names
  end

# Helper Methods
  def scoring(hoa, wol)
    scoring_hash = {}
    @game_teams.each do |game_team|
      if game_team.hoa == hoa
        update_scoring_hash(scoring_hash, game_team) end
    end
    scoring_hash.each_key do |key|
      scoring_hash[key] = scoring_hash[key][0].to_f / scoring_hash[key][1].to_f
    end
    find_name(low_or_high(wol, scoring_hash)) end

  def update_scoring_hash(scoring_hash, game)
    if scoring_hash[game.team_id] == nil
      scoring_hash[game.team_id] = [0,0] end
    scoring_hash[game.team_id][0] += game.goals.to_i
    scoring_hash[game.team_id][1] += 1
    scoring_hash end

  def low_or_high(wol, scoring_hash)
    id  = {'id' => [scoring_hash[scoring_hash.first.first], scoring_hash.first.first]}
    scoring_hash.each_key do |key|
      if id['id'][0] > scoring_hash[key] && wol == 'low'
        update_id(id, key, scoring_hash)
      elsif id['id'][0] < scoring_hash[key] && wol == 'win'
        update_id(id, key, scoring_hash) end
    end
    id['id'][1] end

  def update_id(id, key, scoring_hash)
    id['id'][1] = key.to_i
    id['id'][0] = scoring_hash[key]
    id end

  def home_games
    @game_teams.select { |game_team| game_team.hoa == "home" } end

  def percent_differences
    home_win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }
    home_games.each do |home_game|
      if home_game.result == "WIN"
        home_win_ratios[home_game.team_id][0] += 1
      end
      home_win_ratios[home_game.team_id][1] += 1
    end
    home_win_percentages = home_win_ratios.each_with_object(Hash.new) do |(team_id, home_win_ratio), home_win_percentages|
      home_win_percentages[team_id] = home_win_ratio[0].fdiv(home_win_ratio[1]) * 100
    end

    # away results
    away_games = @game_teams.select do |game_team|
      game_team.hoa == "away"
    end

    away_win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }

    away_games.each do |away_game|
      if away_game.result == "WIN"
        away_win_ratios[away_game.team_id][0] += 1
      end
      away_win_ratios[away_game.team_id][1] += 1
    end

    away_win_percentages = away_win_ratios.each_with_object(Hash.new) do |(team_id, away_win_ratio), away_win_percentages|
      away_win_percentages[team_id] = away_win_ratio[0].fdiv(away_win_ratio[1]) * 100
    end

    # list teams
    team_ids = (home_win_percentages.keys + away_win_percentages.keys).uniq

    # differences
    home_win_percentages.default = 0
    away_win_percentages.default = 0

    percent_differences = {}

    team_ids.each do |team_id|
      percent_differences[team_id] = home_win_percentages[team_id] - away_win_percentages[team_id]
    end
    percent_differences
  end

  def home_id_defense_stats
    @games.group_by(&:home_team_id)
    .map{ |id, away_goals| [id, away_goals.map(&:away_goals).inject(:+)] }.to_h
  end

  def away_id_defense_stats
    @games.group_by(&:away_team_id)
    .map{ |id, away_goals| [id, away_goals.map(&:home_goals).inject(:+)] }.to_h
  end

  def defense_helper
    combined_stats = home_id_defense_stats, away_id_defense_stats
    combined_stats.reduce({}) do |sums, location|
      sums.merge(location) { |_, a, b| a + b }
    end
  end

  def total_games_by_team_id(team_id)
    games_by_team(team_id).length
  end

  def average_defense
    average_defense = {}
    defense_helper.each do |key, value|
      average_defense[key] = total_games_by_team_id(key) / value.to_f
    end
    average_defense
  end
end
