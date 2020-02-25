require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_stats'
require_relative 'league_stats'
require_relative 'season_stats'
require_relative 'team_stats'
require_relative './modules/data_loadable'

class StatTracker
  attr_reader :games, :teams, :game_teams, :game_stats, :league_stats
  include DataLoadable

  def self.from_csv(locations)
    StatTracker.new(locations) end

  def initialize(locations)
    @games = csv_data(locations[:games], Game)
    @teams = csv_data(locations[:teams], Team)
    @game_teams = csv_data(locations[:game_teams], GameTeam)
    @game_stats = GameStats.new(@games)
    @league_stats = LeagueStats.new(@games, @teams, @game_teams)
    @season_stats = SeasonStats.new(@games, @teams, @game_teams)
    @team_stats = TeamStats.new(@games, @teams, @game_teams) end

  def highest_total_score
    @game_stats.highest_total_score end

  def lowest_total_score
    @game_stats.lowest_total_score end

  def biggest_blowout
    @game_stats.biggest_blowout end

  def percentage_home_wins
    @game_stats.percentage_home_wins end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins end

  def percentage_ties
    @game_stats.percentage_ties end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season end

  def average_goals_per_game
    @game_stats.average_goals_per_game end

  def average_goals_by_season
    @game_stats.average_goals_by_season end

  def count_of_teams
    @league_stats.count_of_teams end

  def best_offense
    @league_stats.best_offense end

  def worst_offense
    @league_stats.worst_offense end

  def best_defense
    @league_stats.best_defense end

  def worst_defense
    @league_stats.worst_defense end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team end

  def winningest_team
    @league_stats.winningest_team end

  def best_fans
    @league_stats.best_fans end

  def worst_fans
    @league_stats.worst_fans end

  def biggest_bust(season_id)
    @season_stats.biggest_bust(season_id) end

  def biggest_surprise(season_id)
    @season_stats.biggest_surprise(season_id) end

  def winningest_coach(season_param)
    @season_stats.winningest_coach(season_param) end

  def favorite_opponent(team_param)
    @team_stats.favorite_opponent(team_param) end

  def rival(team_param)
    @team_stats.rival(team_param) end

  def biggest_team_blowout(team_param)
    @team_stats.biggest_team_blowout(team_param) end

  def worst_coach(season_param)
    @season_stats.worst_coach(season_param) end

  def most_tackles(season_param)
    @season_stats.most_tackles(season_param) end

  def fewest_tackles(season_param)
    @season_stats.fewest_tackles(season_param) end

  def most_goals_scored(team_id)
    @team_stats.most_goals_scored(team_id) end

  def fewest_goals_scored(team_id)
    @team_stats.fewest_goals_scored(team_id) end
end
