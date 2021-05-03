require 'rails_helper'

RSpec.describe "UsersEdit", type: :system do
    let(:user) { FactoryBot.create(:user) }
    before do 
        login_as(user)
        click_on '編集する'
    end
    scenario '間違った情報では編集できない' do
        fill_in '名前', with: ' '
        fill_in 'メールアドレス', with: 'user@invalid'
        fill_in 'パスワード', with: 'foo'
        fill_in 'パスワード確認', with: 'bar'
        click_button 'アカウントを更新する'
        aggregate_failures do
          expect(current_path).to eq user_path(user)
          expect(has_css?('.alert-danger')).to be_truthy
        end
    end
    scenario '正しい情報なら編集できる' do
        fill_in '名前', with: '岡 岡'
        fill_in 'メールアドレス', with: 'foo@bar.com'
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_button 'アカウントを更新する'
        aggregate_failures do
          expect(current_path).to eq user_path(user)
          expect(has_css?('.alert-success')).to be_truthy
        end
    end
end