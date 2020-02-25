require_relative 'stats'

class TeamStats < Stats
  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def team_info(team_id)
    {
                "team_id" => team_id,
                "franchiseid" => @teams[team_id].franchise_id,
                "teamname" => @teams[team_id].teamname,
                "abbreviation" => @teams[team_id].abbreviations,
                "link" => @teams[team_id].link
                }
  end
end
