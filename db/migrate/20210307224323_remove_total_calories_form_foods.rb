class RemoveTotalCaloriesFormFoods < ActiveRecord::Migration[6.1]
  def change
    remove_column :foods, :total_calories, :decimal
  end
end
