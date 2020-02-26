class Team
  attr_reader :team_id, :franchise_id, :teamname, :abbreviations, :link

  def initialize(attributes)
    @team_id = attributes[:team_id].to_i
    @franchise_id = attributes[:franchiseid]
    @teamname = attributes[:teamname]
    @abbreviations = attributes[:abbreviations]
    @link = attributes[:link]
  end
end
