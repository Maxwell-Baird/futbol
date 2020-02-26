require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

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
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Game, @stat_tracker.games.first
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Team, @stat_tracker.teams.first
    assert_instance_of Array, @stat_tracker.game_teams
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
    assert_instance_of GameStats, @stat_tracker.game_stats
    assert_instance_of LeagueStats, @stat_tracker.league_stats
  end

  def test_it_can_return_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_return_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_return_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 0.55, @stat_tracker.percentage_home_wins
  end

  def test_it_can_return_percentage_visitor_wins
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.12, @stat_tracker.percentage_ties
  end

  def test_it_can_return_count_number_of_games_by_season
    expected = {"20122013"=>30, "20132014"=>3}

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 4.0, @stat_tracker.average_goals_per_game
  end

  def test_it_can_return_average_goals_by_season
    expected = {"20122013"=>3.97, "20132014"=>4.33}

    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_it_can_return_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_return_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_it_can_return_worst_offense
    assert_equal "FC Cincinnati", @stat_tracker.worst_offense
  end

  def test_it_can_return_best_defense
    assert_equal "Toronto FC", @stat_tracker.best_defense
  end

  def test_it_can_return_worst_defense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_defense
  end

  def test_it_can_return_highest_scoring_visitor
    assert_equal "Real Salt Lake", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_return_highest_scoring_home_team
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_return_lowest_scoring_home_team
    assert_equal "Toronto FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_return_lowest_scoring_visitor
    assert_equal "FC Cincinnati", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_return_winningest_team
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_it_can_return_best_fans
    assert_equal "FC Dallas", @stat_tracker.best_fans
  end

  def test_it_can_return_worst_fans
    assert_equal ["Real Salt Lake", "Minnesota United FC"], @stat_tracker.worst_fans
  end

  def test_game_id_tracks_with_season
    @stat_tracker.games.each do |game|
      assert_equal game.game_id[0..3], game.season[0..3]
    end
  end

  def test_it_can_name_winningest_coach
    assert_equal "Bruce Boudreau", @stat_tracker.winningest_coach("20142015")
  end

  def test_it_can_name_worst_coach
    assert_equal "Darryl Sutter", @stat_tracker.worst_coach("20142015")
  end
  def test_it_can_biggest_bust
    assert_equal "Philadelphia Union", @stat_tracker.biggest_bust('20122013')
  end

  def test_it_can_biggest_surprise
    assert_equal "Toronto FC", @stat_tracker.biggest_surprise('20122013')
  end

  def test_it_can_name_a_favorite_oppponent_team
    assert_equal "Houston Dynamo", @stat_tracker.favorite_opponent("3")
  end

  def test_it_can_name_a_rival_team
    assert_equal "FC Dallas", @stat_tracker.rival("3")
  end

  def test_it_can_return_biggest_team_blowout
    assert_equal 2, @stat_tracker.biggest_team_blowout("3")
  end

  def test_it_returns_name_of_team_with_most_tackles
    assert_equal "Houston Dynamo", @stat_tracker.most_tackles("20132014")
  end

  def test_it_returns_name_of_team_with_fewest_tackles
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
  end

  def test_it_returns_team_info
    expected = {
                "team_id" => 1,
                "franchiseid" => 16,
                "teamname" => "Chicago Fire",
                "abbreviation" => nil,
                "link" => "/api/v1/teams/4"
                }
    assert_equal expected, @stat_tracker.team_info(1)
  end
end
