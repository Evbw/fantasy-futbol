class TeamController < ApplicationController

  get '/teams' do
    @teams = Team.all
    erb :'teams/teams'
  end

  get '/teams/new' do
    erb :'teams/create_team'
  end

  post '/teams' do
    @user = User.find_by(id: session[:user_id])
    @team = Team.create(content: params[:content], user_id: @user.id)
    @team.save
    redirect to "/teams/#{@team.id}"
  end

end
