require 'rails_helper'

RSpec.describe Food, type: :model do
    let(:food) { FactoryBot.create(:food) }

  it "食品名、たんぱく質、炭水化物、脂質、塩、摂取量、時間帯、日付、カロリー、合計カロリーがあれば有効" do
    expect(food).to be_valid
  end

  describe "食品データの関連" do
      let!(:minutes) { FactoryBot.create(:food, :minutes, user: food.user) }
      let!(:hour) { FactoryBot.create(:food, :hour, user: food.user) }
      let!(:most) { FactoryBot.create(:food, :most, user: food.user) }
    it "食品とユーザーの関連付けされている" do
      expect(food.user_id).to eq most.user_id
    end
    it "保存の順番が最新の食品が一番上にくる" do
      expect(Food.first).to eq most
    end
    it "ユーザーを削除すると食品情報も削除される" do
      expect do
        food.user.destroy
      end.to change(Food, :count).by(-4)
    end
  end

  describe "食品名" do
    it "nilならば無効" do
      food.food_name = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.food_name = " "
      expect(food).to_not be_valid
    end
  end

  describe "たんぱく質" do
    it "nilならば無効" do
      food.protein = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.protein = " "
      expect(food).to_not be_valid
    end
  end

  describe "炭水化物" do
    it "nilならば無効" do
      food.carbohydrate = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.carbohydrate = " "
      expect(food).to_not be_valid
    end
  end

  describe "脂質" do
    it "nilならば無効" do
      food.fat = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.fat = " "
      expect(food).to_not be_valid
    end
  end

  describe "塩" do
    it "nilならば無効" do
      food.salt_equivalents = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.salt_equivalents = " "
      expect(food).to_not be_valid
    end
  end

  describe "摂取量" do
    it "nilならば無効" do
      food.quantity = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.quantity = " "
      expect(food).to_not be_valid
    end
  end

  describe "時間帯" do
    it "nilならば無効" do
      food.time_zone = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.time_zone = " "
      expect(food).to_not be_valid
    end
    it "朝、昼、夜、間食、起床、就寝のみ有効" do
      valid_time_zone = [ "朝", "昼", "夜" ,"間食", "起床", "就寝" ]
      valid_time_zone.each do |valid_time_zone|
        food.time_zone = valid_time_zone
        puts "成功確認#{valid_time_zone}OK"  if expect(food).to be_valid
      end
    end
    it "朝、昼、夜、間食、起床、就寝以外は無効" do
      invalid_time_zone = [ "朝食", "昼食", "夕食" ,"間", "起床時", "寝る時" ]
      invalid_time_zone.each do |invalid_time_zone|
        food.time_zone = invalid_time_zone
        puts "失敗確認#{invalid_time_zone}"  if expect(food).to be_invalid
      end
    end
  end

  describe "日付" do
    it "nilならば無効" do
      food.date = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.date = " "
      expect(food).to_not be_valid
    end
  end

  describe "カロリー" do
    it "nilならば無効" do
      food.calorie = nil
      expect(food).to_not be_valid
    end
    it "空欄ならば無効" do
      food.calorie = " "
      expect(food).to_not be_valid
    end
  end

end
