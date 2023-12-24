class ChangeCompletedFieldTypeInExercises < ActiveRecord::Migration[7.1]
  def change
    change_column :exercises, :completed, :integer, default: 0
  end
end
