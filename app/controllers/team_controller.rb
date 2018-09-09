class TeamController < ApplicationController

  get '/teams' do
    @teams = Team.all
    erb :'teams/teams'
  end

  get '/teams/new' do
    erb :'teams/create_team'
  end

  post '/teams' do

  end

end
