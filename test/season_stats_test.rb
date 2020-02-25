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

  def test_winningest_coach
    assert_equal "Bruce Boudreau", @season_stats.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @season_stats.worst_coach("20122013")
  end

  def test_it_can_biggest_bust
    assert_equal "Washington Spirit FC", @season_stats.biggest_bust("20152016")
  end

  def test_it_can_biggest_surprise
    assert_equal "Orlando City SC", @season_stats.biggest_surprise("20152016")
  end

  def test_it_can_difference_percentage
    expected = { 22 => 1.0, 30 => 0.0}
    assert_equal expected, @season_stats.difference_percentage("20152016")
  end
end
