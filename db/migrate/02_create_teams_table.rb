class CreateTeamsTable < ActiveRecord::Migration
  def change
   create_table :teams do |t|
     t.string :team_name
     t.string :team_country
     t.integer :user_id
   end
  end
end
