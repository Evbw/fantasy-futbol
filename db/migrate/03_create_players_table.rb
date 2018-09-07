class CreatePlayersTable < ActiveRecord::Migration
  def change
   create_table :players do |t|
     t.string :player_name
     t.integer :age
     t.string :player_country_of_origin
   end
  end
end
