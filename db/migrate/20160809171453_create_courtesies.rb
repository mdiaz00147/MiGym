class CreateCourtesies < ActiveRecord::Migration
  def change
    create_table :courtesies do |t|
      t.string :name
      t.integer :phone, :limit => 8
      t.string :email
      t.datetime :start_hour

      t.timestamps null: false
    end
  end
end
