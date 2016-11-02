class AddColumnToCourtesiess < ActiveRecord::Migration
  def change
    add_column :courtesies, :schedule_id, :integer
  end
end
