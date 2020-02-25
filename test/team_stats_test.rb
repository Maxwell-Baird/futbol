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
    # A hash with key/value pairs for the following
    # attributes: team_id,
    # franchise_id, team_name, abbreviation, and link

    expected = {
                "team_id" => 1,
                "franchiseid" => 16,
                "teamname" => "Chicago Fire",
                "abbreviation" => nil,
                "link" => "/api/v1/teams/4"
                }
    assert_equal expected, @team_stats.team_info(1)
  end
end
