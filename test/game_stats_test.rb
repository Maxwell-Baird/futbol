require_relative 'test_helper'
require './lib/game'
require './lib/game_stats'
require './lib/modules/data_loadable'

class GameStatsTest < Minitest::Test
  include DataLoadable

  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    @games = csv_data(locations[:games], Game)
    @game_stats = GameStats.new(@games)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_equal @games, @game_stats.games
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

  def test_it_can_calculate_total_scores
    expected = [5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 3, 4, 2, 3, 5, 3, 4, 4, 5, 5, 5,
      7, 3, 5, 5, 3, 4, 2, 6, 4, 3, 5, 5]

    assert_equal expected, @game_stats.total_scores
  end

  def test_it_can_return_score_differences
    expected = [1, 1, 1, 1, 2, 3, 3, 1, 1, 1, 1, 2, 2, 1, 1, 1, 0, 2, 3, 1, 3,
        3, 1, 1, 1, 1, 2, 0, 0, 0, 1, 1, 1]

    assert_equal expected , @game_stats.score_differences
  end

  def test_if_can_find_home_wins
    assert_instance_of Array, @game_stats.home_wins
    assert_equal 18, @game_stats.home_wins.count
  end

  def test_if_can_find_visitor_wins
    assert_instance_of Array, @game_stats.visitor_wins
    assert_equal 11, @game_stats.visitor_wins.count
  end

  def test_it_can_return_ties
    assert_instance_of Array, @game_stats.ties
    assert_equal 4, @game_stats.ties.count
  end

  def test_it_can_calculate_goals_by_season
    expected = {"20122013"=>119, "20132014"=>13}

    assert_equal expected, @game_stats.goals_by_season
  end
end
