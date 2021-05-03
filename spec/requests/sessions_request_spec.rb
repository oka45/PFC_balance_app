require 'rails_helper'

RSpec.describe "sessions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe "GET /" do
    it "ログイン画面が表示されているか" do
      get login_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include "ログイン|PFCバランサー"
   end
  end
  describe "ログイン" do
    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
    end
    it "ログアウトする" do
      delete logout_path
      expect(response).to redirect_to root_path
      expect(is_logged_in?).to be_falsy
    end
  end
  describe 'remember_meチェックボックス' do
    it "チェックを入れた時クッキーを記憶する" do
      log_in_as(user)
      expect(cookies[:remember_token]).not_to eq nil
    end

    it "チェックを入れたなかった時クッキーを記憶しない" do
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end


end
