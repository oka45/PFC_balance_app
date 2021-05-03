require 'rails_helper'

RSpec.describe "foods", type: :system do
  scenario "ユーザーは食品を検索・登録・更新・削除する" do
    user = FactoryBot.create(:user)

    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect(page).to have_content "ログインしました"
    
    visit foods_path

    #空白検索した時のエラー表示
    fill_in "摂取した食品を入力してください", with: " "
    click_button "検索"
    expect(page).to have_content "空白が含まれる為、検索できません"

    #該当する食品がない時のエラー表示
    fill_in "摂取した食品を入力してください", with: "oka"
    click_button "検索"
    expect(page).to have_content "該当する食品がありませんでした"

    #該当する商品があった場合
    fill_in "摂取した食品を入力してください", with: "とんかつ"
    click_button "検索"
    expect(page).to have_content "件の食品が該当しました"

    within'#1600' do
      fill_in "food[quantity]", with: "200"
      select "昼", from: "food[time_zone]"
      click_button "保存"
    end

    expect(page).to have_content "保存しました"

    click_on "編集"
    
    fill_in "quantity", with: "150"
    select "夜", from: "time_zone"
    click_button "保存"

    expect(page).to have_content "食事情報を変更しました"

    click_on "削除"

    expect(page).to have_content "削除しました"

  end


end
