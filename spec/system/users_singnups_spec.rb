require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  scenario '無効なデータを送信した場合、アカウントを作成できない' do
    visit signup_path
    fill_in '名前', with: ' '
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'パスワード', with: 'foo'
    fill_in 'パスワード確認', with: 'bar'
    click_on 'アカウントを作成する'
    aggregate_failures do
      expect(current_path).to eq users_path
      expect(page.title).to have_content '新規登録'
      expect(page).to have_content 'The form contains 4 error.'
    end
  end
  scenario '有効なデータを送信した場合、アカウントを作成できる' do
    visit signup_path
    fill_in '名前', with: 'Example User'
    fill_in 'メールアドレス', with: 'user@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード確認', with: 'password'
    click_on 'アカウントを作成する'
    aggregate_failures do
      expect(current_path).to eq user_path(User.last)
      expect(has_css?('.alert-success')).to be_truthy
      visit current_path 
      expect(has_css?('.alert-success')).to be_falsy
    end
  end
end
