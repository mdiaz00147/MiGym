class DestroyAddDocumentToUsersToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :add_document_to_users
  end
end
