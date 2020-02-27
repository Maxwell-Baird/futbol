class Team
  attr_reader :team_id, :franchise_id, :teamname, :abbreviation, :link

  def initialize(attributes)
    @team_id = attributes[:team_id].to_i
    @franchise_id = attributes[:franchiseid]
    @teamname = attributes[:teamname]
    @abbreviation = attributes[:abbreviation]
    @link = attributes[:link]
  end

  def find_name(id)
    @teams.find { |team| team.team_id == id }.teamname
  end

  def unique_team_ids
    @game_teams.uniq { |game_team| game_team.team_id}.map { |game_team| game_team.team_id }
  end

  def total_games_by_team(team_id)
    games_by_team(team_id).length
  end
end
