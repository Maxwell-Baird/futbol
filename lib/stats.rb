class Stats
  attr_reader :games, :teams, :game_teams
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def find_name(id)
    team = @teams.find { |team| team.team_id == id }
    team.teamname
  end
end
