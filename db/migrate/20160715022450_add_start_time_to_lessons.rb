class AddStartTimeToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :start_hour, :time
  end
end
