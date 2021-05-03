require 'rails_helper'

RSpec.describe "UsersLogins", type: :system do
    let(:user) { FactoryBot.create(:user) }

    scenario '無効な情報ではログインできない' do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: ' '
      click_button 'ログイン'
      aggregate_failures do
        expect(current_path).to eq login_path
        expect(has_css?('.alert-danger')).to be_truthy
        visit current_path
        expect(has_css?('.alert-danger')).to be_falsy
      end
    end
    scenario '有効な情報はログインできログアウトする' do
        visit login_path
        fill_in 'メールアドレス',    with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        aggregate_failures do
          expect(current_path).to eq user_path(user)
          expect(page).to have_no_link 'ログイン'
          expect(page).to have_no_link '用途'
          expect(page).to have_link 'PFC管理',       href: foods_path
          expect(page).to have_link 'プロフィール', href: user_path(user)
          expect(page).to have_link 'ログアウト',       href: logout_path
          expect(page).to have_content "ログインしました"
        end
        click_on "ログアウト"
        aggregate_failures do
            expect(current_path).to eq root_path
            expect(page).to have_link 'ログイン', href: login_path
            expect(page).to have_link '用途', href: about_path
            expect(page).to have_no_link 'ログアウト'
            expect(page).to have_no_link 'プロフィール'
        end
        
    end
end