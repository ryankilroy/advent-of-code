class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :title
      t.integer :day
      t.boolean :completed

      t.timestamps
    end
  end
end
