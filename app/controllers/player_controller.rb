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

end
