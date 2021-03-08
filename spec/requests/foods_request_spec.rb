require 'rails_helper'

RSpec.describe "Foods", type: :request do

  describe '食品をDBへ保存テスト' do
    let(:food){ attributes_for(:food) }
    let(:post_request){post foods_path, params: { food: food }}

    context 'ログインしてない場合' do
      it '管理ページへアクセスできない' do

      end
      it '食品情報を保存できない' do
        expect { post_request }.to change(Food, :count).by(0)
      end
      it '食品情報を保存しようとするとログイン画面へリダイレクト' do
        expect( post_request ).to redirect_to login_url
      end
    end
  end
  describe '食品をDBへ削除テスト' do
    let!(:food){ create(:food) }
    let(:destroy_request){delete food_path(food) }
    context 'ログインしてない場合' do
      it '食品情報を削除できない' do
        expect { destroy_request }.to change(Food, :count).by(0)
      end
      it '食品情報を削除しようとするとログイン画面へリダイレクト' do
        expect( destroy_request ).to redirect_to login_url
      end
    end
  end

end
