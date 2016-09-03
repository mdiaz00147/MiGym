class ChangeDateFormatInLessons < ActiveRecord::Migration
  def change
  	change_column :lessons, :start_date, :datetime
  end
end
