class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :food_name
      t.decimal :protein, precision: 4, scale: 1
      t.decimal :carbohydrate, precision: 4, scale: 1
      t.decimal :fat, precision: 4, scale: 1
      t.decimal :salt_equivalents, precision: 4, scale: 1
      t.decimal :calorie, precision: 4, scale: 1
      t.decimal :total_calories, precision: 4, scale: 1
      t.decimal :quantity, precision: 4, scale: 1
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :foods, [:user_id, :created_at]
  end
end
