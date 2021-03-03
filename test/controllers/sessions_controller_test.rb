require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "PFCバランサー"
  end
  
  test "should get new" do
    get login_path
    assert_response :success
    assert_select "title", "ログイン|#{@base_title}"
  end
end
