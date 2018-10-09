class TeamController < ApplicationController

  get '/teams' do
    redirect_if_not_logged_in
    @teams = Team.all
    erb :'teams/teams'
  end

  get '/teams/new' do
    redirect_if_not_logged_in
    erb :'teams/create_team'
  end

  post '/teams' do
    redirect_if_not_logged_in
    if params[:team_name] == "" || params[:team_country] == ""
      redirect to "/teams/new"
    else
      @user = User.find_by(id: session[:user_id])
      @team = Team.create(team_name: params[:team_name], team_country: params[:team_country], user_id: @user.id)
      @team.save
      redirect to "/teams/#{@team.id}"
    end
  end

  get '/teams/:id' do
    redirect_if_not_logged_in
    @team = Team.find_by_id(params[:id])
    erb :'/teams/show_team'
  end

  get '/teams/:id/edit' do
    redirect_if_not_logged_in
    @team = Team.find_by_id(params[:id])
    if @team && @team.user == current_user
       erb :'teams/edit_team'
    else
    redirect to '/teams'
    end
  end

  patch '/teams/:id' do
   @team = Team.find(params[:id])
   @user = User.find_by(id: session[:user_id])
   redirect_if_not_logged_in
    if @team.user_id == @user.id
     @team.update(team_name: params[:team_name])
     @team.update(team_country: params[:team_country])
     redirect to "/teams/#{@team.id}"
    elsif params[:team_name].empty? || params[:team_country].empty? && @team.user_id == @user.id
      redirect to("/teams/#{@team.id}/edit")
    elsif !params[:team_name].empty? && @team.user_id != @user.id
      redirect to("/teams")
    end
  end

  delete '/teams/:id/delete' do
    redirect_if_not_logged_in
    @team = Team.find_by_id(params[:id])
    if @team && @team.user_id == current_user
      @team.destroy
      redirect to '/teams'
    end
  end

end
