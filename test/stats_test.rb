require_relative 'test_helper'
require './lib/stats'
require 'mocha/minitest'
class StatsTest < Minitest::Test
  def setup
    @games = mock('games')
    @teams = mock('teams')
    @game_teams = mock('game_teams')
    @stats = Stats.new(@games, @teams, @game_teams)
  end
  def test_it_can_exist
    assert_instance_of Stats, @stats
  end
  def test_it_has_attributes
    assert_equal @games, @stats.games
    assert_equal @teams, @stats.teams
    assert_equal @game_teams, @stats.game_teams
  end

  def test_it_can_find_name
  # Test goes here
  end
end
