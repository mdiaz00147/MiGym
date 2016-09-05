class AddColumnLastEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_email, :datetime
  end
end
