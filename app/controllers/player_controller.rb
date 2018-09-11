class PlayerController < ApplicationController

  get '/players' do
    @players = Player.all
    erb :'players/players'
  end

  get '/players/new' do
    erb :'players/create_player'
  end

  post '/players' do
    @user = User.find_by(id: session[:user_id])
    @player = Player.create(content: params[:content], user_id: @user.id)
    @player.save
    redirect to "/players/#{@player.id}"
  end

  get '/players/:id' do
    @player = Player.find_by_id(params[:id])
    erb :'/players/show_player'
  end

  get '/players/:id/edit' do
    @player = Player.find_by_id(params[:id])
    erb :'players/edit_player'
  end

  patch '/players/:id' do
    @player = Player.find(params[:id])
    @player.update(player_name: params[:player_name])
    @player.update(age: params[:age])
    @player.update(player_country_of_origin: params[:player_country_of_origin])
    redirect to "/players/#{@player.id}"
  end

end
