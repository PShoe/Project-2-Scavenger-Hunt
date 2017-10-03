require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'
require_relative 'db_config'
require_relative 'models/player'
require_relative 'models/team'
require_relative 'models/treasure'

enable :sessions

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
    # session[:user_id] = user.id
    redirect '/treasure'
  else
    @message = "incorrect email or password"
    erb :login
  end
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
