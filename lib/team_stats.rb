require_relative 'stats'

class TeamStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def team_info(team_id)
    team = @teams.select { |team| team.team_id.to_s == team_id }.first
    {
      "team_id" => team_id.to_s,
      "franchiseid" => team.franchise_id.to_s,
      "teamname" => team.teamname,
      "abbreviation" => team.abbreviation,
      "link" => team.link
      }
  end

  def favorite_opponent(team_id)
    games_with_team = @games.select do |game|
      game.away_team_id == team_id.to_i || game.home_team_id == team_id.to_i
    end

    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }

    #same method in league_stats and maybe elsewhere - candidate for Stats
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

    # look into hash merge instead of each with object
    win_percentages = win_ratios.each_with_object(Hash.new) do |(team_id, win_ratio), win_percent|
      win_percent[team_id] = win_ratio[0].fdiv(win_ratio[1]) * 100
    end

    team_id = win_percentages.key(win_percentages.values.min)
    find_name(team_id)
  end

  def rival(team_id)
    # find team that wins against this team most often
    games_with_team = @games.select do |game|
      game.away_team_id == team_id.to_i || game.home_team_id == team_id.to_i
    end

    win_ratios = Hash.new { |hash, key| hash[key] = [0,0] }

    #same method in league_stats and maybe elsewhere - candidate for Stats
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

    # look into hash merge instead of each with object
    win_percentages = win_ratios.each_with_object(Hash.new) do |(team_id, win_ratio), win_percent|
      win_percent[team_id] = win_ratio[0].fdiv(win_ratio[1]) * 100
    end

    team_id = win_percentages.key(win_percentages.values.max)
    find_name(team_id)
  end

  def biggest_team_blowout(team_id)
    games_with_team = @games.select do |game|
      game.away_team_id == team_id.to_i || game.home_team_id == team_id.to_i
    end

    game_with_biggest_blowout = games_with_team.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end

    difference = game_with_biggest_blowout.away_goals - game_with_biggest_blowout.home_goals
    difference.abs
  end
end
