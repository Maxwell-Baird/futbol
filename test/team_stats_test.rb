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

  def test_it_can_name_a_favorite_oppponent_team
    game_path = './data/games_truncated_with_winningest_team.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    stat_tracker = StatTracker.from_csv(locations)
    team_stats = TeamStats.new(stat_tracker.games, stat_tracker.teams, stat_tracker.game_teams)

    assert_equal "Seattle Sounders FC", team_stats.favorite_opponent(3)
  end

  def test_it_can_name_a_rival_team
    game_path = './data/games_truncated_with_winningest_team.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    stat_tracker = StatTracker.from_csv(locations)
    team_stats = TeamStats.new(stat_tracker.games, stat_tracker.teams, stat_tracker.game_teams)

    assert_equal "Atlanta United", team_stats.rival(3)
  end

  def test_it_can_return_biggest_team_blowout
    game_path = './data/games_truncated_with_winningest_team.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    stat_tracker = StatTracker.from_csv(locations)
    team_stats = TeamStats.new(stat_tracker.games, stat_tracker.teams, stat_tracker.game_teams)

    assert_equal "Houston Dynamo", team_stats.biggest_team_blowout(1)
  end
end
