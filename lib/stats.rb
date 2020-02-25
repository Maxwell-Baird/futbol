class Stats
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def find_name(team_id)
    team = @teams.find { |team| team.team_id == team_id }
    team.teamname
  end

  def season_game_teams(season_param)
    @game_teams.select do |game_team|
      (game_team.game_id/1000000).to_s == season_param[0..3]
    end
  end
end
