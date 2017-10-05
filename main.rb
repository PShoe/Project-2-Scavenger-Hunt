require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'
require_relative 'db_config'
require_relative 'models/player'
require_relative 'models/team'
require_relative 'models/treasure'
require_relative 'models/players_treasures_team'
require_relative 'models/comment'

# require_relative 'treasure_methods'
require 'httparty'


enable :sessions

# API_KEY = '&APPID=d10ed7fa849100a3d43e443f9ba5b599'
# need to hide this in bash_profile

# add a new challenge?

@weather_response = HTTParty.get('http://api.openweathermap.org/data/2.5/weather?id=7839805&APPID=d10ed7fa849100a3d43e443f9ba5b599').parsed_response


helpers do
  def current_player
    Player.find_by(id: session[:player_id])
  end
  def logged_in?
    !!current_player
  end

  def create_link_with_comment treasure, comment
    tag = ''
    content = "#{comment.body} -#{comment.player.name}, #{comment.player.team.name}"
    if current_player == comment.player
      tag += "<a href='/edit?treasure_id=#{treasure.id}&comment_id=#{comment.id}'>"
      tag += content
      tag += "</a>"
    else
      tag += content
    end
    return tag
  end
end


get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/session' do
  player = Player.find_by(email: params[:email])
  # if !player
    if player && player.authenticate(params[:password])
      session[:player_id] = player.id
      redirect '/treasure'
    else
      @message = "incorrect email or password"
      erb :login
    end
  end
# end

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

  @weather_response = HTTParty.get('http://api.openweathermap.org/data/2.5/weather?id=7839805&APPID=d10ed7fa849100a3d43e443f9ba5b599').parsed_response
  @condition = @weather_response['weather'].first['main']
  @min_temp = @weather_response['main']['temp_min']
  @min_temp = (@min_temp - 273.15).to_i
  @max_temp = @weather_response['main']['temp_max']
  @max_temp = (@max_temp - 273.15).to_i

  team_id = current_player.team_id
  @treasures_found = PlayersTreasuresTeam.where(team_id: team_id)
  @treasures_not_found =
  Treasure.joins("left outer join (select * from players_treasures_teams where team_id = #{team_id}) as found on treasures.id = found.treasure_id where team_id is null");

  player = current_player
  @player_points = player.treasures.sum(:point_value)
  # could add these as for each loops
  @wdi_image = Team.find(3).image_url
  @ds_image = Team.find(2).image_url
  @ux_image = Team.find(1).image_url
  @wdi_points = Team.find(3).treasures.sum(:point_value)
  @ds_points = Team.find(2).treasures.sum(:point_value)
  @ux_points = Team.find(1).treasures.sum(:point_value)
  erb :treasure
end

post '/found' do
  # make a new record in linking table
  found_record = PlayersTreasuresTeam.new
  found_record.treasure_id = params[:treasure_id]
  found_record.player_id = current_player.id
  found_record.team_id = current_player.team_id
  found_record.save
  # redirect '/treasure'
  @treasure = Treasure.find(params[:treasure_id])
  @comments = Comment.where(treasure_id: params[:treasure_id])
  erb :show
end

post '/comments' do
  comment = Comment.new
  comment.body = params[:body]
  comment.treasure_id = params[:treasure_id]
  comment.player_id = current_player.id
  comment.team_id = current_player.team_id
  comment.save
  redirect '/treasure'
end

get '/edit' do
  @treasure = Treasure.find(params[:treasure_id])
  @comment = Comment.find(params[:comment_id])
  erb :edit
end

put '/edit' do
  @comment = Comment.find(params[:comment_id])
  @comment.body = params[:body]
  @comment.save
  redirect '/treasure'
end
