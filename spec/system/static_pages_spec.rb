require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  scenario "ログインしていない時のヘッダーのリンク先" do
    visit root_path
    aggregate_failures do
      expect(page).to have_link 'TOP',       href: root_path
      expect(page).to have_link '用途', href: about_path
      expect(page).to have_link 'ログイン',       href: login_path
      expect(page).to have_link 'PFCバランサー',      href: root_path
    end
  end
  scenario "ログインした時のヘッダーのリンク先" do
    user = FactoryBot.create(:user)

    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    aggregate_failures do
      expect(page).to have_link 'PFC管理',       href: foods_path
      expect(page).to have_link 'プロフィール', href: user_path(user)
      expect(page).to have_link 'ログアウト',       href: logout_path
    end
    click_on "PFCバランサー"
    sleep 1.0
    expect(current_path).to eq foods_path
  end
end