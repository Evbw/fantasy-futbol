class TeamController < ApplicationController

  get '/teams' do
    if logged_in?
      @teams = Team.all
      erb :'teams/teams'
    end
  end

  get '/teams/new' do
    if logged_in?
      erb :'teams/create_team'
    end
  end

  post '/teams' do
    @user = User.find_by(id: session[:user_id])
    @team = Team.create(content: params[:content], user_id: @user.id)
    @team.save
    redirect to "/teams/#{@team.id}"
  end

  get '/teams/:id' do
    if logged_in?
      @team = Team.find_by_id(params[:id])
      erb :'/teams/show_team'
    end
  end

  get '/teams/:id/edit' do
    if logged_in?
      @team = Team.find_by_id(params[:id])
      erb :'teams/edit_team'
    end
  end

  patch '/teams/:id' do
   @team = Team.find(params[:id])
   if logged_in?
     @team.update(team_name: params[:team_name])
     @team.update(team_country: params[:team_country])
     redirect to "/teams/#{@team.id}"
   end
  end

  delete '/teams/:id/delete' do
    if logged_in?
      @team = Team.find_by_id(params[:id])
      @team.destroy
      redirect to '/teams'
    end
  end

end
