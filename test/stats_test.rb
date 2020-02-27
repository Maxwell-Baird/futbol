require_relative 'test_helper'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stats'
require './lib/modules/data_loadable'

class StatsTest < Minitest::Test
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
    @teams = csv_data(locations[:teams], Team)
    @game_teams = csv_data(locations[:game_teams], GameTeam)
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
