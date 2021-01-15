require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "PFCバランサー"
  end

  test "should get root(ルーティング、ルートのテスト)" do
    get root_url
    assert_response :success
  end

  test "should get home(ホームページのテスト)" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "TOP|#{@base_title}"
  end

  test "shold get about"do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "使い方|#{@base_title}"
  end

end
