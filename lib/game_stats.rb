require_relative 'stats'

class GameStats < Stats

  def initialize(games)
    super(games, teams, game_teams)
  end

  def highest_total_score
    total("away_goals", "home_goals", @games).max
  end

  def lowest_total_score
    total("away_goals", "home_goals", @games).min
  end

  def biggest_blowout
    @games.map { |game| (game.away_goals - game.home_goals).abs }.max
  end

  def percentage_home_wins
    round(home_wins.length.to_f / @games.length)
  end

  def percentage_visitor_wins
    round(vistor_wins.length.to_f / @games.length)
  end

  def percentage_ties
    ties = @games.count do |game|
      game.away_goals == game.home_goals
    end
    round(ties.fdiv(@games.length))
  end

  def count_of_games_by_season
    @games.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    all_goals = @games.sum { |game| game.away_goals + game.home_goals }
    round(all_goals.to_f / @games.length)
  end

  def average_goals_by_season
    goals_per_season = {}
    @games.each do |game|
      if goals_per_season[game.season] == nil
        goals_per_season[game.season] = game.away_goals + game.home_goals
      else
        goals_per_season[game.season] += game.away_goals + game.home_goals
      end
    end
    count = count_of_games_by_season
    @games.reduce(Hash.new(0)) do |average_goals, game|
      average_goals[game.season] = (goals_per_season[game.season].to_f / count[game.season]).round(2)
      average_goals
    end
  end

  #helper methods
  def home_wins
    @games.find_all { |game| game.away_goals < game.home_goals }
  end

  def vistor_wins
    @games.find_all { |game| game.away_goals > game.home_goals }
  end
end
