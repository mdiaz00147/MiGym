class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :add_document_to_users, :string
    add_column :users, :phone, :numeric
    add_column :users, :document, :numeric
  end
end
