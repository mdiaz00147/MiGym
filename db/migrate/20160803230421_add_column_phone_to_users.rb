class AddColumnPhoneToUsers < ActiveRecord::Migration
   def change
  	add_column :users, :phone, :integer, :limit => 8
  	add_column :users, :document, :integer, :limit => 8
  end
end
