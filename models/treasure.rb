class Treasure < ActiveRecord::Base
  has_many :players_treasures_teams
end
