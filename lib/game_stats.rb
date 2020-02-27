require_relative 'stats'

class GameStats < Stats

  def initialize(games)
    super(games, teams, game_teams)
  end

  def highest_total_score
    total_scores.max
  end

  def lowest_total_score
    total_scores.min
  end

  def biggest_blowout
    score_differences.max
  end

  def percentage_home_wins
    percentage(home_wins.length, @games.length)
  end

  def percentage_visitor_wins
    percentage(visitor_wins.length, @games.length)
  end

  def percentage_ties
    percentage(ties.length, @games.length)
  end

  def count_of_games_by_season
    @games.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
  end

  def average_goals_per_game
    percentage(total_scores.sum, @games.length)
  end

  def average_goals_by_season
    average_hashes(goals_by_season, count_of_games_by_season)
  end

  # Helper Methods
  def total_scores
    @games.map { |game| game.home_goals + game.away_goals }
  end

  def score_differences
    @games.map { |game| (game.home_goals - game.away_goals).abs }
  end

  def home_wins
    @games.select { |game| game.home_goals > game.away_goals }
  end

  def visitor_wins
    @games.select { |game| game.home_goals < game.away_goals }
  end

  def ties
    @games.select { |game| game.home_goals == game.away_goals }
  end

  def goals_by_season
    @games.reduce(Hash.new(0)) do |goals_by_season, game|
      goals_by_season[game.season] += game.home_goals + game.away_goals
      goals_by_season
    end
  end
end
