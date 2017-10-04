require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'
require_relative 'db_config'
require_relative 'models/player'
require_relative 'models/team'
require_relative 'models/treasure'
require_relative 'models/players_treasures_team'
require_relative 'treasure_methods'

enable :sessions


helpers do
  def current_player
    Player.find_by(id: session[:player_id])
  end
  def logged_in?
    !!current_player
  end
end


get '/' do
  erb :index
end

# USER CAN LOG IN AND CHOOSE A TEAM
get '/login' do
  erb :login
end

post '/session' do
  player = Player.find_by(email: params[:email])
  if player && player.authenticate(params[:password])
    session[:player_id] = player.id
    redirect '/treasure'
  else
    @message = "incorrect email or password"
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

get '/register' do
  erb :register
end

post '/register' do
  team_id = Team.find_by(name: params[:team]).id
  player = Player.new
  player.name = params[:name]
  player.email = params[:email]
  player.password = params[:password]
  player.points = 0
  player.team_id = team_id
  player.save
  redirect '/login'
end

get '/treasure' do
  team_id = current_player.team_id
  @treasures_found = PlayersTreasuresTeam.where(team_id: team_id)
  @treasures_not_found = Treasure.left_outer_joins(:players_treasures_teams).where('players_treasures_teams.play_tre_tm_id is null')
  # @current_player = current_player
  ## need to specify team
  player = current_player
  @player_points = player.treasures.sum(:point_value)

  # add score to team
  team = player.team
  @team_points = team.treasures.sum(:point_value)

  erb :treasure
end

post '/found' do
  # Add treasure as found to linking table
  # treasure_id = params[:treasure_id]
  # treasure = Treasure.where(id: treasure_id).first
  # treasure.found = true
  # treasure.save

  # make a new record in linking table
  found_record = PlayersTreasuresTeam.new
  found_record.treasure_id = params[:treasure_id]
  found_record.player_id = current_player.id
  found_record.team_id = current_player.team_id
  found_record.save
  redirect '/treasure'
end
