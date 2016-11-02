class AddColumnToCourtesies < ActiveRecord::Migration
  def change
    add_column :courtesies, :status, :boolean
  end
end
