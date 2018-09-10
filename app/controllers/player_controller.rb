class PlayerController < ApplicationController

  get '/players' do
    @players = Player.all
    erb :'players/players'
  end

end
