require_relative 'test_helper'
require './lib/team_stats'
require './lib/stat_tracker'

class TeamStatsTest < Minitest::Test
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
    @team_stats = TeamStats.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
  end


  def test_it_returns_team_info
    expected = {
                "team_id" => "18",
                "franchise_id" => "34",
                "team_name" => "Minnesota United FC",
                "abbreviation" => "MIN",
                "link" => "/api/v1/teams/18"
                }
    assert_equal expected, @team_stats.team_info("18")
  end

  def test_it_can_name_a_favorite_oppponent_team
    assert_equal "Houston Dynamo", @team_stats.favorite_opponent("3")
  end

  def test_it_can_name_a_rival_team
    assert_equal "FC Dallas", @team_stats.rival("3")
  end

  def test_it_can_return_biggest_team_blowout
    assert_equal 2, @team_stats.biggest_team_blowout("3")
  end
end
