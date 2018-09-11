class PlayerController < ApplicationController

  get '/players' do
    @players = Player.all
    erb :'players/players'
  end

  get '/players/new' do
    erb :'players/create_player'
  end

end
