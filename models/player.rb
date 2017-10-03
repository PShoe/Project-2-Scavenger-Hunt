class Player < ActiveRecord::Base
  has_secure_password
  has_many :players_treasures_teams
end
