require_relative 'test_helper'
require './lib/game_stats'
require './lib/stat_tracker'

class GameStatsTest < Minitest::Test
  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    @locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                 }
    @stat_tracker = StatTracker.from_csv(@locations)
    @game_stats = GameStats.new(@stat_tracker.games)
  end
  
  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_stats.games
    assert_instance_of Game, @game_stats.games.first
  end

  def test_returns_highest_total_score
    assert_equal 7, @game_stats.highest_total_score
  end

  def test_returns_lowest_total_score
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_returns_biggest_blowout
    assert_equal 3, @game_stats.biggest_blowout
  end

  def test_if_can_find_home_wins
    assert_instance_of Array, @game_stats.home_wins
  end

  def test_if_can_find_visitor_wins
    assert_instance_of Array, @game_stats.visitor_wins
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.55, @game_stats.percentage_home_wins
  end

  def test_it_can_calculate_percentage_vistor_wins
    assert_equal 0.33, @game_stats.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.12, @game_stats.percentage_ties
  end

  def test_it_can_count_games_by_season
    expected = {"20122013"=>30, "20132014"=>3}

    assert_equal expected, @game_stats.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 4.0, @game_stats.average_goals_per_game
  end

  def test_it_can_calculate_average_goals_per_season
    expected = {"20122013"=>3.97, "20132014"=>4.33}

    assert_equal expected, @game_stats.average_goals_by_season
  end
end
