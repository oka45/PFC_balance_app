class ChangeOptionTotalCaloriesToFoods < ActiveRecord::Migration[6.1]
  def change
    change_column :foods, :total_calories, :decimal, precision: 4, scale: 1
  end
end
