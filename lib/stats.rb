require_relative './modules/compiler'

class Stats
  include Compilable
  extend Compilable

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def percentage(part, whole)
    part.fdiv(whole).round(2)
  end

  def find_by_collection(element, attribute, collection)
    collection.find_all { |bv| bv.send(attribute) == element }
  end

  def average_hashes(hash1, hash2)
    hash1.merge(hash2) { |key, value| percentage(hash1[key], hash2[key]) }
  end

  def find_name(id)
    @teams.find { |team| team.team_id == id }.teamname
  end

  def count_of_teams
    @teams.count
  end

  def unique_team_ids
    @game_teams.uniq { |game_team| game_team.team_id}
    .map { |game_team| game_team.team_id }
  end

  def games_by_team(team_id)
    find_by_collection(team_id, "team_id", @game_teams)
  end

  def total_games_by_team_id(team_id)
    games_by_team(team_id).length
  end

  def total_shots_by_team_id(team_id)
    games_by_team(team_id).sum { |game_team| game_team.shots }
  end

  def total_goals_by_team_id(team_id)
    games_by_team(team_id).sum { |game_team| game_team.goals }
  end

  def average_goals_per_team(team_id)
    total_goals_by_team_id(team_id).to_f / total_games_by_team_id(team_id).to_f
  end

  def season_game_teams(season_param)
    @game_teams.select do |game_team|
      (game_team.game_id/1000000).to_s == season_param[0..3]
    end
  end

  def shot_accuracy_by_team_id(team_id)
    (total_goals_by_team_id(team_id).to_f/total_shots_by_team_id(team_id) * 100.0)
    .floor
  end
end
