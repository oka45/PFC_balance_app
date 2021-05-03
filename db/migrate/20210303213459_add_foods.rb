class AddFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :time_zone, :string
  end
end
