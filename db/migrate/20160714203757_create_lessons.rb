class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.date :start_date
      t.integer :users_allowed
      t.string :name

      t.timestamps null: false
    end
  end
end
