class Food < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  with_options presence: true do
    validates :user_id
    validates :food_name
    validates :protein
    validates :carbohydrate
    validates :fat
    validates :salt_equivalents
    validates :calorie
    validates :total_calories
    validates :quantity
    validates :date
  end
end
