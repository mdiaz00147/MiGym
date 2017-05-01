class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :whatsapp, :integer
    add_column :users, :address, :string
  end
end
