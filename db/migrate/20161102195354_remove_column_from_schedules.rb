class RemoveColumnFromSchedules < ActiveRecord::Migration
  def change
    remove_column :schedules, :courtesie_id, :string
  end
end
