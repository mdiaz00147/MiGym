class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :lessons
      t.integer :price
      t.string :start_hour
      t.string :end_hour

      t.timestamps null: false
    end
  end
end
