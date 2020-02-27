require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_instance_of GameStats, @stat_tracker.game_stats
    assert_instance_of LeagueStats, @stat_tracker.league_stats
    assert_instance_of SeasonStats, @stat_tracker.season_stats
    assert_instance_of TeamStats, @stat_tracker.team_stats
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
    assert_equal 2, @stat_tracker.biggest_team_blowout("17")
  end

  def test_it_returns_name_of_team_with_most_tackles
    assert_equal "Houston Dynamo", @stat_tracker.most_tackles("20132014")
  end

  def test_it_returns_name_of_team_with_fewest_tackles
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
  end

  def test_average_win_percentage
    assert_equal 1.0, @stat_tracker.average_win_percentage("1")
  end

  def test_best_season
    assert_equal "20122013", @stat_tracker.best_season("1")
  end

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("1")
  end

  def test_most_goals_scored
    assert_equal 5, @stat_tracker.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("3")
  end

  def test_it_returns_team_info
    expected = {
                "team_id" => "18",
                "franchise_id" => "34",
                "team_name" => "Minnesota United FC",
                "abbreviation" => "MIN",
                "link" => "/api/v1/teams/18"
                }
    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_it_can_return_worst_loss
    assert_equal 3, @stat_tracker.worst_loss("5")
  end

  def test_it_can_make_a_head_to_head_hash
    assert_equal ({"New York Red Bulls" => 0.6}), @stat_tracker.head_to_head("9")
  end

  def test_it_can_build_seasonal_summary
    skip
    expected = {"20162017"=>
      {:postseason=>
        {:win_percentage=>0.59,
         :total_goals_scored=>48,
         :total_goals_against=>40,
         :average_goals_scored=>2.18,
         :average_goals_against=>1.82},
       :regular_season=>
        {:win_percentage=>0.38,
         :total_goals_scored=>180,
         :total_goals_against=>170,
         :average_goals_scored=>2.2,
         :average_goals_against=>2.07}},
     "20172018"=>
      {:postseason=>
        {:win_percentage=>0.54,
         :total_goals_scored=>29,
         :total_goals_against=>28,
         :average_goals_scored=>2.23,
         :average_goals_against=>2.15},
       :regular_season=>
        {:win_percentage=>0.44,
         :total_goals_scored=>187,
         :total_goals_against=>162,
         :average_goals_scored=>2.28,
         :average_goals_against=>1.98}},
     "20132014"=>
      {:postseason=>
        {:win_percentage=>0.0,
         :total_goals_scored=>0,
         :total_goals_against=>0,
         :average_goals_scored=>0.0,
         :average_goals_against=>0.0},
       :regular_season=>
        {:win_percentage=>0.38,
         :total_goals_scored=>166,
         :total_goals_against=>177,
         :average_goals_scored=>2.02,
         :average_goals_against=>2.16}},
     "20122013"=>
      {:postseason=>
        {:win_percentage=>0.0,
         :total_goals_scored=>0,
         :total_goals_against=>0,
         :average_goals_scored=>0.0,
         :average_goals_against=>0.0},
       :regular_season=>
        {:win_percentage=>0.25,
         :total_goals_scored=>85,
         :total_goals_against=>103,
         :average_goals_scored=>1.77,
         :average_goals_against=>2.15}},
     "20142015"=>
      {:postseason=>
        {:win_percentage=>0.67,
         :total_goals_scored=>17,
         :total_goals_against=>13,
         :average_goals_scored=>2.83,
         :average_goals_against=>2.17},
       :regular_season=>
        {:win_percentage=>0.5,
         :total_goals_scored=>186,
         :total_goals_against=>162,
         :average_goals_scored=>2.27,
         :average_goals_against=>1.98}},
     "20152016"=>
      {:postseason=>
        {:win_percentage=>0.36,
         :total_goals_scored=>25,
         :total_goals_against=>33,
         :average_goals_scored=>1.79,
         :average_goals_against=>2.36},
       :regular_season=>
        {:win_percentage=>0.45,
         :total_goals_scored=>178,
         :total_goals_against=>159,
         :average_goals_scored=>2.17,
         :average_goals_against=>1.94}}}

    assert_equal expected, @league_stats.seasonal_summary("3")
  end
end
