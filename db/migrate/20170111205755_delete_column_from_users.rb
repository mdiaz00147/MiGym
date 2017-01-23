class DeleteColumnFromUsers < ActiveRecord::Migration
  def change
  	remove_column :points, :belongs_to
  	add_column	:points, :user_id, :integer
  end
end
