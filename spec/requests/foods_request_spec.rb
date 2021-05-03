require 'rails_helper'

RSpec.describe "Foods", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe "#index" do
    context "ログイン済みユーザー" do
      let!(:food) { FactoryBot.create(:food, user: user)}
      let!(:today) { FactoryBot.create(:food, :today, user: food.user) }
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      it "リクエストが成功する" do
        get foods_path
        expect(response).to have_http_status "200"
      end
      it "今日の食品を登録できる管理ページが表示されている" do
        get foods_path
        expect(response.body).to include "#{Date.current.strftime('%m月%d日')}"
      end
      it "今日の食品以外は表示されない" do
      get foods_path
      expect(response.body).to_not include "鶏卵　全卵　ゆで"
      end
      it "食品はdateの日付に表示される" do
        get foods_path, params: { format: "2021-03-02" }
        expect(response.body).to include "鶏卵　全卵　ゆで"
      end
    end
    context "ゲストユーザー" do
      it "管理ページへアクセスできない" do
        get foods_path
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトする" do
        get foods_path
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#create" do
    let!(:food) { FactoryBot.create(:food, user: user)}
    context "ログイン済みユーザー" do
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      it "食品を保存できる" do
        expect{
          post foods_path, params: {
            food: FactoryBot.attributes_for(:food)
          }
        }.to change(user.foods, :count).by(1)
      end
      it "リダイレクトされる" do
      @food_params = FactoryBot.attributes_for(:food)
      post foods_path, params: {
        food: @food_params,
      }
      expect(flash[:success]).to be_present
      expect(response).to redirect_to "/foods.#{@food_params[:date]}"
      end
      it "パラメータが不正な場合保存できない" do
        expect{
          post foods_path, params: {
            food: FactoryBot.attributes_for(:food, :invalid, user: food.user)
          }
        }.to_not change(user.foods, :count)
      end
      
    end


    context "ゲストユーザー" do
      it "管理ページへアクセスできない" do
        @food_params = FactoryBot.attributes_for(:food)
          post foods_path, params: {
            food: @food_params,
          }
          expect(response).to_not be_successful
          expect(response).to have_http_status "302"
      end
      it "サインイン画面にリダイレクトする" do
        post foods_path, params: {
          food: @food_params,
        }
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#update" do
    context "ログイン済みユーザー" do
      let!(:food) { FactoryBot.create(:food, user: user) }
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      it "食品を更新できる" do
        food_params = FactoryBot.attributes_for(:food, quantity: 300 )
          patch food_path(food), params: {
            id: food.id,
            quantity: food_params[:quantity]
          }
        expect(food.reload.quantity).to eq 300
      end
      it "リダイレクトされる" do
        @food_params = FactoryBot.attributes_for(:food, quantity: 300 )
          patch food_path(food), params: {
            id: food.id,
            quantity: @food_params[:quantity]
          }
          expect(response).to redirect_to "/foods.#{@food_params[:date]}"
      end
    end
  end

  describe "#destroy" do
    let!(:food) { FactoryBot.create(:food, user: user) }
    context "ログインユーザー" do
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      it "食品を削除できる" do
        expect{
          delete food_path(food), params: {
            id: food.id
          }
        }.to change(user.foods, :count).by(-1)
      end
      it "リダイレクトされる" do
        delete food_path(food), params: {
          id: food.id
        }
        expect(response).to redirect_to "/foods.#{Date.parse(Date.current.strftime('%Y/%m/%d'))}"
      end
    end
    context "ログインしていないユーザー" do
      before do
        post login_path, params: { session: { email: other_user.email, password: other_user.password } }
      end
      it "他人の食品を削除できない" do
        expect{
          delete food_path(food), params: {
            id: food.id
          }
        }.to change(user.foods, :count).by(0)
      end
    end
  end

end
