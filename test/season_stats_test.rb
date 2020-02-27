require_relative 'test_helper'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/season_stats'
require './lib/modules/data_loadable'

class SeasonStatsTest < Minitest::Test
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
    games = csv_data(locations[:games], Game)
    teams = csv_data(locations[:teams], Team)
    game_teams = csv_data(locations[:game_teams], GameTeam)
    @season_stats = SeasonStats.new(games, teams, game_teams)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_it_has_attributes
    assert_instance_of Array, @season_stats.games
    assert_instance_of Game, @season_stats.games.first
    assert_instance_of Array, @season_stats.teams
    assert_instance_of Team, @season_stats.teams.first
    assert_instance_of Array, @season_stats.game_teams
    assert_instance_of GameTeam, @season_stats.game_teams.first
  end

  def test_it_returns_name_of_team_with_most_tackles
    assert_equal "Houston Dynamo", @season_stats.most_tackles("20132014")
  end

  def test_it_returns_name_of_team_with_fewest_tackles
    assert_equal "Atlanta United", @season_stats.fewest_tackles("20132014")
  end

  def test_it_can_return_most_accurate_team
    assert_equal "Minnesota United FC", @season_stats.most_accurate_team("20152016")
  end

  def test_it_can_return_least_accurate_team
    assert_equal "FC Cincinnati", @season_stats.least_accurate_team("20142015")
  end

  def test_winningest_coach
    assert_equal "Bruce Boudreau", @season_stats.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @season_stats.worst_coach("20122013")
  end


  def test_it_can_return_hash_with_shots_and_goals_per_team
    expected = {24=>0.375, 20=>0.5, 26=>0.16666666666666666}

    assert_equal expected, @season_stats.shots_and_goals_per_team("20142015")
  end

  def test_it_can_biggest_bust
    assert_equal "Philadelphia Union", @season_stats.biggest_bust("20122013")
  end

  def test_it_can_biggest_surprise
    assert_equal "Toronto FC", @season_stats.biggest_surprise("20122013")
  end


end
