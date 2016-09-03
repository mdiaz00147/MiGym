class AddLimitToUserPhone < ActiveRecord::Migration
  def down
      	 remove_column :users, :phone
  end
end
