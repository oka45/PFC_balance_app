require 'rails_helper'

RSpec.describe Food, type: :model do
    let(:food) { FactoryBot.create(:food) }

  #食品名、たんぱく質、炭水化物、脂質、塩、摂取量、時間帯、日付、カロリー、合計カロリーがあれば有効
  it "is valid with a food_name,　protein, carbohydrate, fat, salt_equivalents, quantity, time_zone, date, calorie, total_calories " do
    expect(food).to be_valid
  end

  describe "when save" do
      let!(:minutes) { FactoryBot.create(:food, :minutes, user: food.user) }
      let!(:hour) { FactoryBot.create(:food, :hour, user: food.user) }
      let!(:most) { FactoryBot.create(:food, :most, user: food.user) }
    #食品とユーザーの関連付け
    it "Relationship between food and users" do
      expect(food.user_id).to eq most.user_id
    end
    #保存の順番が最新の食品が一番上にくるか
    it "the food with the latest storage order come to the top" do
      expect(Food.first).to eq most
    end
    #ユーザーを削除すると食品情報も削除される
    it "when you delete a user, food information is also deleted." do
      expect do
        food.user.destroy
      end.to change(Food, :count).by(-4)
    end
  end

  describe "food_name" do
    #食品名がnilならば無効
    it "is invalid without food_name" do
      food.food_name = nil
      food.valid?
      expect(food.errors[:food_name]).to include("can't be blank")
    end
    #食品名が空欄ならば無効
    it "is invalid blank food_name" do
      food.food_name = " "
      food.valid?
      expect(food.errors[:food_name]).to include("can't be blank")
    end
  end

  describe "protein" do
    #たんぱく質がなければ無効
    it "is invalid without protein" do
      food.protein = nil
      food.valid?
      expect(food.errors[:protein]).to include("can't be blank")
    end
    #たんぱく質が空欄ならば無効
    it "is invalid blank protein" do
      food.protein = " "
      food.valid?
      expect(food.errors[:protein]).to include("can't be blank")
    end
  end

  describe "carbohydrate" do
    #炭水化物がなければ無効
    it "is invalid without carbohydrate" do
      food.carbohydrate = nil
      food.valid?
      expect(food.errors[:carbohydrate]).to include("can't be blank")
    end
    #炭水化物が空欄ならば無効
    it "is invalid blank carbohydrate" do
      food.carbohydrate = " "
      food.valid?
      expect(food.errors[:carbohydrate]).to include("can't be blank")
    end
  end

  describe "fat" do
    #脂質がなければ無効
    it "is invalid without fat" do
      food.fat = nil
      food.valid?
      expect(food.errors[:fat]).to include("can't be blank")
    end
    #脂質が空欄ならば無効
    it "is invalid blank fat" do
      food.fat = " "
      food.valid?
      expect(food.errors[:fat]).to include("can't be blank")
    end
  end

  describe "salt_equivalents" do
    #塩がなければ無効
    it "is invalid without salt_equivalents" do
      food.salt_equivalents = nil
      food.valid?
      expect(food.errors[:salt_equivalents]).to include("can't be blank")
    end
    #塩が空欄ならば無効
    it "is invalid blank salt_equivalents" do
      food.salt_equivalents = " "
      food.valid?
      expect(food.errors[:salt_equivalents]).to include("can't be blank")
    end
  end

  describe "quantity" do
    #摂取量がなければ無効
    it "is invalid without quantity" do
      food.quantity = nil
      food.valid?
      expect(food.errors[:quantity]).to include("can't be blank")
    end
    #摂取量が空欄ならば無効
    it "is invalid blank quantity" do
      food.quantity = " "
      food.valid?
      expect(food.errors[:quantity]).to include("can't be blank")
    end
  end

  describe "time_zone" do
    #時間帯がなければ無効
    it "is invalid without time_zone" do
      food.time_zone = nil
      food.valid?
      expect(food.errors[:time_zone]).to include("can't be blank")
    end
    #時間帯が空欄ならば無効
    it "is invalid blank time_zone" do
      food.time_zone = " "
      food.valid?
      expect(food.errors[:time_zone]).to include("can't be blank")
    end
    #時間帯は朝、昼、夜、間食、起床、就寝のみ有効
    it "valid only in the morning, noon, night, snacks, getting up, and going to bed" do
      valid_time_zone = [ "朝", "昼", "夜" ,"間食", "起床", "就寝" ]
      valid_time_zone.each do |valid_time_zone|
        food.time_zone = valid_time_zone
        puts "成功確認#{valid_time_zone}OK"  if expect(food).to be_valid
      end
    end
    #時間帯は朝、昼、夜、間食、起床、就寝以外は無効
    it "time zone is invalid except morning, noon, night, snack, wake up, bedtime" do
      invalid_time_zone = [ "朝食", "昼食", "夕食" ,"間", "起床時", "寝る時" ]
      invalid_time_zone.each do |invalid_time_zone|
        food.time_zone = invalid_time_zone
        puts "失敗確認#{invalid_time_zone}"  if expect(food).to be_invalid
      end
    end
  end

  describe "date" do
    #日付がなければ無効
    it "is invalid without date" do
      food.date = nil
      food.valid?
      expect(food.errors[:date]).to include("can't be blank")
    end
    #日付が空欄ならば無効
    it "is invalid blank date" do
      food.date = " "
      food.valid?
      expect(food.errors[:date]).to include("can't be blank")
    end
    #未来の日付は無効
    it "invalid except for date" do
      future_date = Date.today + 1
      food.date = future_date
      food.valid?
      expect(food).to_not be_valid
    end
  end

  describe "calorie" do
    #カロリーがなければ無効
    it "is invalid without calorie" do
      food.calorie = nil
      food.valid?
      expect(food.errors[:calorie]).to include("can't be blank")
    end
    #カロリーが空欄ならば無効
    it "is invalid blank calorie" do
      food.calorie = " "
      food.valid?
      expect(food.errors[:calorie]).to include("can't be blank")
    end
  end

  #合計カロリーがなければ無効
  it "is invalid without total_calories" do
    food.calorie = nil
    food.quantity = nil
    food.total_calories = nil
    expect(food).to_not be_valid
  end

end
