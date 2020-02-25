require_relative 'test_helper'
require './lib/stats'
require 'mocha/minitest'
<<<<<<< HEAD
=======

>>>>>>> a171b9d23617a5156fcb92627efdf51be29ef31f
class StatsTest < Minitest::Test
  def setup
    @games = mock('games')
    @teams = mock('teams')
    @game_teams = mock('game_teams')
<<<<<<< HEAD
    @stats = Stats.new(@games, @teams, @game_teams)
  end
  def test_it_can_exist
    assert_instance_of Stats, @stats
  end
=======

    @stats = Stats.new(@games, @teams, @game_teams)
  end

  def test_it_can_exist
    assert_instance_of Stats, @stats
  end

>>>>>>> a171b9d23617a5156fcb92627efdf51be29ef31f
  def test_it_has_attributes
    assert_equal @games, @stats.games
    assert_equal @teams, @stats.teams
    assert_equal @game_teams, @stats.game_teams
  end

<<<<<<< HEAD
  def test_it_can_find_name
  # Test goes here
=======
  def test_it_can_return_all_games_in_a_season
    # add test with mock/stub
>>>>>>> a171b9d23617a5156fcb92627efdf51be29ef31f
  end
end
