require 'rails_helper'

RSpec.describe Food, type: :model do

  describe 'Foodモデル' do
    let(:food) {FactoryBot.create(:food) }
      it 'バリテーションが機能してるか' do
        expect(food).to be_valid
      end
      context 'foodの表示順序' do
          let!(:minutes) {FactoryBot.create(:food, :minutes) }
          let!(:most) {FactoryBot.create(:food, :most) }
          let!(:hour) {FactoryBot.create(:food, :hour) }
        it '最新で並び替え' do
          expect(Food.first).to eq most
        end
      end
    context 'user_idのバリテーション'do
      it 'nilなら登録できない' do
        food.user_id = nil
        expect(food).to be_invalid
      end
      it '関連付いてないと登録できない' do
        expect(food.user_id).to eq food.user.id
      end
    end
    context 'food_nameのバリテーション' do
      it '空欄は登録できない' do
        food.food_name = " "
        expect(food).to be_invalid
      end
    end
    context 'proteinのバリテーション' do
      it 'nilは登録できない' do
        food.protein = nil
        expect(food).to be_invalid
      end

    end
    context 'carbohydrateのバリテーション' do
      it 'nilは登録できない' do
        food.carbohydrate = nil
        expect(food).to be_invalid
      end
    end
    context 'fatのバリテーション' do
      it 'nilは登録できない' do
        food.fat = nil
        expect(food).to be_invalid
      end
    end
    context 'salt_equivalentsのバリテーション' do
      it 'nilは登録できない' do
        food.salt_equivalents = nil
        expect(food).to be_invalid
      end
    end
    context 'calorieのバリテーション' do
      it 'nilは登録できない' do
        food.calorie = nil
        expect(food).to be_invalid
      end
    end
    context 'total_caloriesのバリテーション' do
      it 'nilは登録できない' do
        food.total_calories = nil
        expect(food).to be_invalid
      end
    end
    context 'quantityのバリテーション' do
      it 'nilは登録できない' do
        food.quantity = nil
        expect(food).to be_invalid
      end
    end
    context 'dateのバリテーション' do
      it '空欄は登録できない' do
        food.date = " "
        expect(food).to be_invalid
      end
    end


    #context '存在の確認'


      #it "foodのfood_nameが存在しているか？"
      #it "foodのproteinが存在しているか？"
      #it "foodのcarbohydrateが存在しているか？"
      #it "foodのfatが存在しているか？"
      #it "foodのsalt_equivalentsが存在しているか？"
      #it "foodのcalorieが存在しているか？"
      #it "foodのtotal_caloriesが存在しているか？"
      #it "foodのquantityが存在しているか？"
  end
end
