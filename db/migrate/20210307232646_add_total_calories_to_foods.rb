class AddTotalCaloriesToFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :total_calories, :decimal
  end
end
