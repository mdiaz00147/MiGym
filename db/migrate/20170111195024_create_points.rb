class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :belongs_to
      t.datetime :valid_thru

      t.timestamps null: false
    end
  end
end
