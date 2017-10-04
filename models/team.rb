class Team < ActiveRecord::Base
  has_many :players
  has_many :players_treasures_teams
  has_many :treasures, through: :players_treasures_teams
end
