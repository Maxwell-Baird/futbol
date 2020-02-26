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
    assert_equal "Houston Dynamo", @team_stats.favorite_opponent("3")
  end

  def test_it_can_name_a_rival_team
    assert_equal "FC Dallas", @team_stats.rival("3")
  end

  def test_it_can_return_biggest_team_blowout
    skip
    assert_equal 2, @team_stats.biggest_team_blowout("3")
  end

  def test_average_win_percentage
    assert_equal 1.0, @team_stats.average_win_percentage("1")
  end

  def test_best_season
    assert_equal "20122013", @team_stats.best_season("1")
  end

  def test_worst_season
    assert_equal "20122013", @team_stats.worst_season("1")
  end

  def test_most_goals_scored
    assert_equal 5, @team_stats.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 0, @team_stats.fewest_goals_scored("3")
  end

  def test_win_percentage_per_season
    expected = {"20122013" => 0.0}
    assert_equal expected, @team_stats.win_percentage_per_season("3")
  end

  def test_check_empty
    game = Game.new({
      game_id: '2015030226',
      season: '20152016',
      type: "Postseason",
      away_team_id: 15,
      home_team_id: 5,
      away_goals: 3,
      home_goals: 2
      })
    input_hash = {}
    assert_equal [0,0], @team_stats.check_empty(game, input_hash)
  end
end
