class PlayerController < ApplicationController

  get '/players' do
    redirect_if_not_logged_in
    @players = Player.all
    erb :'players/players'
  end

  get '/players/new' do
    redirect_if_not_logged_in
    erb :'players/create_player'
  end

  post '/players' do
    redirect_if_not_logged_in
    if params[:player_name] == "" || params[:age] == "" || params[:player_country_of_origin] == ""
      redirect to "/players/new"
    else
      @user = User.find_by(id: session[:user_id])
      @player = Player.create(player_name: params[:player_name], age: params[:age], player_country_of_origin: params[:player_country_of_origin], team_id: params[:user][:team_id])
      @player.save
      redirect to "/players/#{@player.id}"
    end
  end

  get '/players/:id' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    erb :'/players/show_player'
  end

  get '/players/:id/edit' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    if @player && @player.user == current_user
      erb :'players/edit_player'
    else
      redirect to '/players'
    end
  end

  patch '/players/:id' do
    @player = Player.find(params[:id])
    @user = User.find_by(id: session[:user_id])
    redirect_if_not_logged_in
    if !params[:player_name].empty? && !params[:player_country_of_origin].empty? && !params[:age].empty? && @team.user_id == @user.id
      @player = Player.find(params[:id])
      @player.update(player_name: params[:player_name])
      @player.update(age: params[:age])
      @player.update(player_country_of_origin: params[:player_country_of_origin])
      redirect to "/players/#{@player.id}"
    elsif params[:player_name].empty? && @player.user_id == @user.id
      redirect to("/players/#{@player.id}/edit")
    elsif !params[:player_name].empty? && @player.user_id != @user.id
      redirect to("/players")
    end
  end

  delete '/players/:id/delete' do
    redirect_if_not_logged_in
    @player = Player.find_by_id(params[:id])
    if @player && @player.user == current_user
      @player.destroy
      redirect to '/players'
    end
  end

end
