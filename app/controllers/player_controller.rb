class PlayerController < ApplicationController

  get '/players' do
    if logged_in?
      @players = Player.all
      erb :'players/players'
    end
  end

  get '/players/new' do
    if logged_in?
      erb :'players/create_player'
    end
  end

  post '/players' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @player = Player.create(content: params[:content], user_id: @user.id)
      @player.save
      redirect to "/players/#{@player.id}"
    end
  end

  get '/players/:id' do
    if logged_in?
      @player = Player.find_by_id(params[:id])
      erb :'/players/show_player'
    end
  end

  get '/players/:id/edit' do
    if logged_in?
      @player = Player.find_by_id(params[:id])
      erb :'players/edit_player'
    end
  end

  patch '/players/:id' do
    if logged_in?
      @player = Player.find(params[:id])
      @player.update(player_name: params[:player_name])
      @player.update(age: params[:age])
      @player.update(player_country_of_origin: params[:player_country_of_origin])
      redirect to "/players/#{@player.id}"
    end
  end

  delete '/players/:id/delete' do
    if logged_in?
      @player.destroy
      redirect to '/players'
    end
  end

end
