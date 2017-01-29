class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :body_water
      t.integer :body_fat
      t.integer :bone
      t.integer :bmi
      t.integer :visceral_fat
      t.integer :bmr
      t.integer :muscle_mass
      t.integer :metabolic_age
      t.integer :weight
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
