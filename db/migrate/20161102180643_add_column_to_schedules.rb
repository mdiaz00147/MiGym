class AddColumnToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :courtesie_id, :integer
  end
end
