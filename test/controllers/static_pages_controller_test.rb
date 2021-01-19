require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "PFCバランサー"
  end


  test "should get home(ルートホームページのテスト)" do
    get root_path
    assert_response :success
    assert_select "title", "TOP|#{@base_title}"
  end

  test "shold get about"do
    get about_path
    assert_response :success
    assert_select "title", "用途|#{@base_title}"
  end

  test "should get management(管理ページのテスト)"do
    get management_path
    assert_response :success
    assert_select "title", "PFC管理|#{@base_title}"
  end

end
