require 'rails_helper'

RSpec.describe Food, type: :model do

  describe 'Foodモデル' do
    let(:user){ create(:user) }
    let(:food){ create(:food) }
      it 'バリテーションが機能してるか' do
        expect(food).to be_valid
      end
    context 'foodの表示順序' do
        let!(:minutes) {create(:food, :minutes) }
        let!(:hour) {create(:food, :hour) }
        let!(:most) {create(:food, :most) }
      it '食品内容が同じユーザーからされているか' do
        pending("複数のユーザーが作られてしまう")
        expect(food.user_id).to eq most.user_id
      end
      it '最新で並び替え' do
        expect(Food.first).to eq most
      end
    end
    context 'ユーザーと食品の関係' do
      before do
        user.foods.create(food_name: "＜畜肉類＞_ぶた　［大型種肉］　ロース　脂身つき　とんかつ　" ,
        protein: 22 ,
        carbohydrate: 9.8,
        fat: 35.9,
        salt_equivalents: 0.3,
        calorie: 450,
        total_calories: 450,
        quantity: 100,
        date: "2021-03-02",
        time_zone: "夜",
      )
      end
      it 'ユーザーを削除するとユーザーの食品情報も削除される' do
        expect do
          user.destroy
        end.to change(Food, :count).by(-1)
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



  end
end
