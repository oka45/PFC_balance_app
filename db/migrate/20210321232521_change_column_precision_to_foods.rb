class ChangeColumnPrecisionToFoods < ActiveRecord::Migration[6.1]
  def change
    change_column :foods, :protein, :decimal, precision: 6, scale: 1
    change_column :foods, :carbohydrate, :decimal, precision: 6, scale: 1
    change_column :foods, :fat, :decimal, precision: 6, scale: 1
    change_column :foods, :salt_equivalents, :decimal, precision: 6, scale: 1
    change_column :foods, :calorie, :decimal, precision: 6, scale: 1
    change_column :foods, :quantity, :decimal, precision: 6, scale: 1
    change_column :foods, :total_calories, :decimal, precision: 6, scale: 1
  end

end
