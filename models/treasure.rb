class Treasure < ActiveRecord::Base
   has_many :players_treasures_teams
   has_many :players, through: :players_treasures_teams
end
