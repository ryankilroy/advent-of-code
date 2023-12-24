class AddPathToExercise < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :path, :string
  end
end
