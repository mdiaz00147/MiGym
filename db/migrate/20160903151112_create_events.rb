class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :event_name
      t.string :option_1
      t.string :option_2
      t.string :option_3

      t.timestamps null: false
    end
  end
end
