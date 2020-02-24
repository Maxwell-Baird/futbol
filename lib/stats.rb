class Stats
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def games_by_team(team_id)
    @game_teams.find_all { |team| team.team_id == team_id }
  end

  def total_goals_by_team_id(team_id)
    games_by_team(team_id).sum { |game_team| game_team.goals }
  end

  def total_shots_by_team_id(team_id)
    games_by_team(team_id).sum { |game_team| game_team.shots }
  end
end
