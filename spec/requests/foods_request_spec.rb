require 'rails_helper'

RSpec.describe "Foods", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe "#index" do
    #ログイン済みユーザー
    context "login user" do
      let!(:food) { FactoryBot.create(:food, user: user)}
      let!(:today) { FactoryBot.create(:food, :today, user: food.user) }
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      #リクエストが成功する
      it "responds successfully" do
        get foods_path
        expect(response).to have_http_status "200"
      end
      #今日の食品を登録できる管理ページが表示されている
      it "today's management page is displayed" do
        get foods_path
        expect(response.body).to include "とうもろこし　コーンフラワー　黄色種"
      end
      #今日の食品以外は表示されない
      it "only today's foods are listed" do
      get foods_path
      expect(response.body).to_not include "鶏卵　全卵　ゆで"
      end
      #食品はdateの日付に表示される
      it "is displayed on the date of date" do
        get foods_path, params: { format: "2021-03-02" }
        expect(response.body).to include "鶏卵　全卵　ゆで"
      end
    end
    #ゲストユーザー
    context "guest user" do
      #管理ページへアクセスできない
      it "cannot access the management page" do
        get foods_path
        expect(response).to_not be_successful
        expect(response).to have_http_status "302"
      end
      #サインイン画面にリダイレクトする
      it "redirect to the sign_in page" do
        get foods_path
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#create" do
    let!(:food) { FactoryBot.create(:food, user: user)}
    #ログイン済みユーザー
    context "login user" do
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      #食品を保存できる
      it "adds a food" do
        expect{
          post foods_path, params: {
            food: FactoryBot.attributes_for(:food)
          }
        }.to change(user.foods, :count).by(1)
      end
      #リダイレクトされる
      it "redirect to management page" do
      @food_params = FactoryBot.attributes_for(:food)
      post foods_path, params: {
        food: @food_params,
      }
      expect(response).to redirect_to "/foods.#{@food_params[:date]}"
      end
      #パラメータが不正な場合保存できない
      it "Cannot save if the parameter is invalid" do
        expect{
          post foods_path, params: {
            food: FactoryBot.attributes_for(:food, :invalid, user: food.user)
          }
          binding.pry
        }.to_not change(user.foods, :count)
      end
    end


    #ゲストユーザー
    context "guest user" do
      #管理ページへアクセスできない
      it "cannot access the management page" do
        @food_params = FactoryBot.attributes_for(:food)
          post foods_path, params: {
            food: @food_params,
          }
          expect(response).to_not be_successful
          expect(response).to have_http_status "302"
      end
      #サインイン画面にリダイレクトする
      it "redirect to the sign_in page" do
        post foods_path, params: {
          food: @food_params,
        }
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#update" do
    #ログイン済みユーザー
    context "login user" do
      let!(:food) { FactoryBot.create(:food, user: user) }
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      #食品を更新できる
      it "update a food" do
        food_params = FactoryBot.attributes_for(:food, quantity: 300 )
          patch food_path(food), params: {
            id: food.id,
            quantity: food_params[:quantity]
          }
        expect(food.reload.quantity).to eq 300
      end
      #リダイレクトされる
      it "redirect to management page" do
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
    #ログインユーザー
    context "login user" do
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end
      #食品を削除できる
      it "can delete food" do
        expect{
          delete food_path(food), params: {
            id: food.id
          }
        }.to change(user.foods, :count).by(-1)
      end
      #リダイレクトされる
      it "redirect to management page" do
        delete food_path(food), params: {
          id: food.id
        }
        expect(response).to redirect_to "/foods.#{Date.parse(Date.current.strftime('%Y/%m/%d'))}"
      end
    end
    #ログインしていないユーザー
    context "who are not logged user" do
      before do
        post login_path, params: { session: { email: other_user.email, password: other_user.password } }
      end
      #他人の食品を削除できない
      it "can't delete someone food" do
        expect{
          delete food_path(food), params: {
            id: food.id
          }
        }.to change(user.foods, :count).by(0)
      end
    end
  end

end
