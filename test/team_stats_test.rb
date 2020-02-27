require_relative 'test_helper'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/team_stats'
require './lib/modules/data_loadable'

class TeamStatsTest < Minitest::Test
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
    @team_stats = TeamStats.new(@games, @teams, @game_teams)
  end

  def test_it_an_exist
    assert_instance_of TeamStats, @team_stats
  end

  def test_it_has_attributes
    assert_equal @games, @team_stats.games
    assert_equal @teams, @team_stats.teams
    assert_equal @game_teams, @team_stats.game_teams
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
    assert_equal 2, @team_stats.biggest_team_blowout("17")
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

  def test_count_wins
    game = Game.new({
      game_id: '2015030226',
      season: '20152016',
      type: "Postseason",
      away_team_id: 15,
      home_team_id: 5,
      away_goals: 3,
      home_goals: 4
      })
    seasons = {}
    assert_equal 1, @team_stats.count_wins(game, seasons, '5')
  end

  def test_it_can_return_worst_loss
    assert_equal 3, @team_stats.worst_loss("5")
  end

  def test_it_can_make_a_head_to_head_hash
    assert_equal ({"New York Red Bulls" => 0.6}), @team_stats.head_to_head("9")
  end

  def test_it_can_build_seasonal_summary
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

    assert_equal expected, @team_stats.seasonal_summary("3")
  end
end
