class Food < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  before_validation do
    self.total_calories = calorie * (quantity * 0.01)
    #self.date =
  end

  with_options presence: true do
    validates :user_id
    validates :food_name
    validates :protein
    validates :carbohydrate
    validates :fat
    validates :salt_equivalents
    validates :calorie
    validates :quantity
    validates :time_zone
    validates :total_calories
    validates :date
  end

  def start_time
    self.date
  end

  



end
