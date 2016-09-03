class AddColumnToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :start_date, :datetime
  end
end
