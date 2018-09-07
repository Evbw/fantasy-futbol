class CreateTeamsTable < ActiveRecord::Migration
  def change
   create_table :team do |t|
     t.string :team_name
     t.string :team_country
   end
  end
end
