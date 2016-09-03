class AddColumnPhoneToLessons < ActiveRecord::Migration
  def change
  	add_column :lessons, :users_enrolled, :integer
  end
end
