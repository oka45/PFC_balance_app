require 'rails_helper'

RSpec.describe "FoodsApi", type: :request do
  describe "#index オラクルのDBからの食品情報取得するAPIテスト" do
    let(:user) { FactoryBot.create(:user) }
    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
    end
    it "リクエストが成功する" do
      get foods_path, params: { name: "とんかつ"}
      expect(response).to have_http_status(200)
    end
    context "入力内容が有効な場合" do
      it "食品名を検索すると該当する食品情報が返ってくる" do
        get foods_path, params: { name: "とんかつ"}
        food_information = controller.instance_variable_get('@food_information')
        aggregate_failures do
          food_information.each do |f|
            expect( f[:food_and_description] ).to include("とんかつ")
            expect( f[:protein] ).to be_present
            expect( f[:carbohydrate] ).to be_present
            expect( f[:fat] ).to be_present
            expect( f[:salt_equivalents] ).to be_present
            expect( f[:energy__kcal_] ).to be_present
          end
        end
      end
      it "該当食品がある場合、何件該当したかメッセージが表示される" do 
        get foods_path, params: { name: "とんかつ"}
        food_information = controller.instance_variable_get('@food_information')
        expect(response.body).to include "2件の食品が該当しました" 
      end
    end
    context "入力内容が無効な場合" do
      it "空欄を入力した場合、管理ページにリダイレクトされる" do
        get foods_path, params: { name: " "}
        expect(response).to render_template(:index)
      end
      it "リダイレクトされるとエラーが表示される" do
        get foods_path, params: { name: " " }
        expect(response.body).to include "空白が含まれる為、検索できません"
      end
      it "該当する食品がない場合、管理ページにリダイレクトされる" do 
        get foods_path, params: { name: "とまと"}
        expect(response).to render_template(:index)
      end
      it "該当する食品がない場合、リダイレクトされるとエラーが表示される" do
        get foods_path, params: { name: "とまと" }
        expect(response.body).to include "該当する食品がありませんでした"
      end
        
      it "日本語以外を入力した場合、管理ページにリダイレクトされる" do 
        get foods_path, params: { name: "oka"}
        expect(response).to render_template(:index)
      end
      it "日本語以外を入力した場合、リダイレクトされるとエラーが表示される" do
        get foods_path, params: { name: "とまと" }
        expect(response.body).to include "該当する食品がありませんでした"
      end
    end



  end

end
