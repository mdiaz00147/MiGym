class AddColumnToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :phone, :intger, :limit => 8
  	add_column :users, :document, :intger, :limit => 8
  end
end
