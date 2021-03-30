require 'rails_helper'

RSpec.describe "FoodsApi", type: :request do
  #オラクルのDBからの食品情報取得するAPIテスト
  describe "#index oracle API" do
    let(:user) { FactoryBot.create(:user) }
    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
    end
    #リクエストが成功する
    it "responds successfully" do
      get foods_path, params: { name: "とんかつ"}
      expect(response).to have_http_status(200)
    end
    #入力内容が有効な場合
    context "the input is valid" do
      #食品名を検索すると該当する食品情報が返ってくる
      it "when you search for a food name, the corresponding food information is returned" do
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
    end
    #入力内容が無効な場合
    context "the input is invalid" do
      #空欄を入力した場合管理ページにリダイレクトされる
      it "enter blank　redirected to the management page" do
        get foods_path, params: { name: " "}
        expect(response).to render_template(:index)
      end
      #リダイレクトされるとエラーが表示される
      it "リダイレクトされるとエラーが表示される" do
        get foods_path, params: { name: " " }
        expect(response.body).to include "空白文字だけの可能性があるため検索できません"
      end
    end

      #日本語以外を入力した場合
      #該当する食品がない場合



  end

end
