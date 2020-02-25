require_relative 'test_helper'
require './lib/season_stats'
require './lib/stat_tracker'

class SeasonStatsTest < Minitest::Test
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
    @season_stats = SeasonStats.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
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
    skip
    assert_equal "the", @season_stats.most_accurate_team(20152016)
  end



  # def test_it_can_return_least_accurate_team
  #   assert_equal "the", @season_stats.least_accurate_team(20142015)
  # end

  def test_winningest_coach
    assert_equal "Bruce Boudreau", @season_stats.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @season_stats.worst_coach("20122013")
  end

  def test_it_can_biggest_bust
    assert_equal "Philadelphia Union", @season_stats.biggest_bust("20122013")
  end

  def test_it_can_biggest_surprise
    assert_equal "Toronto FC", @season_stats.biggest_surprise("20122013")
  end

end
