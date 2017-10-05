class Player < ActiveRecord::Base
  has_secure_password
  belongs_to :team
  has_many :players_treasures_teams
  has_many :treasures, through: :players_treasures_teams
  has_many :comments
end
