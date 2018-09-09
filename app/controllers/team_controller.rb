class TeamController < ApplicationController

  get '/teams' do
    @teams = Team.all
    erb :'teams/teams'
  end

end
