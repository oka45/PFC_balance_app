class Food < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  with_options presence: true do
    validates :user_id, :food_name, :date
    validates :time_zone, inclusion: { in: [ "朝", "昼", "夜" ,"間食", "起床", "就寝" ] }
    with_options numericality: true  do
      validates :protein,:carbohydrate, :fat, :salt_equivalents, :calorie, :quantity
    end
  end

  def start_time
    self.date
  end

  def total_protein
    self.protein * (self.quantity * 0.01).round(1)
  end

  def total_carbohydrate
    self.carbohydrate * (self.quantity * 0.01).round(1)
  end

  def total_fat
    self.fat * (self.quantity * 0.01).round(1)
  end

  def total_salt_equivalents
    self.salt_equivalents * (self.quantity * 0.01).round(1)
  end

  def total_calorie
    self.calorie * (self.quantity * 0.01).round(2)
  end

  def today_total_calories
    self.sum("total_calorie").round(1)
  end



end
