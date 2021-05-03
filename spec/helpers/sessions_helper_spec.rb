require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }

  describe 'current_user' do
    before do
      remember(user)
    end

    it '永続セッションの確認' do
      expect(current_user).to eq user
      expect(is_logged_in?).to be_truthy
    end
    it '永続セッションのダイジェストが違う場合nilを返す' do
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to eq nil
    end
  end
end