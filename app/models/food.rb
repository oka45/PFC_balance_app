class Food < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validate :calorie_calculation, :date_start
  with_options presence: true do
    validates :user_id, :food_name, :date
    validates :time_zone, inclusion: { in: [ "朝", "昼", "夜" ,"間食", "起床", "就寝" ] }
    with_options numericality: true  do
      validates :protein,:carbohydrate, :fat, :salt_equivalents, :calorie, :quantity, :total_calories
    end
  end


  def start_time
    self.date
  end

  private
  def calorie_calculation
    if !calorie.blank? && !quantity.blank?
      self.total_calories = calorie * (quantity * 0.01)
    end
  end

  def date_start
    unless date == nil
      errors.add(:date, 'は、今日を含む過去の日付を入力して下さい') if date > Date.today
    end
  end

end
