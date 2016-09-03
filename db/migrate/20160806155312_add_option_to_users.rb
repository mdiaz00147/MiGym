class AddOptionToUsers < ActiveRecord::Migration
  def change
  	add_column :schedules, :options, :string
  end
end
