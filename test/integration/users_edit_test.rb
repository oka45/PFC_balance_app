require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test "無効な編集" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params:{user: {name: "",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar"}}
    assert_template 'users/edit'
    assert_select 'div.alert'
  end

  test "successful edit(有効な編集)" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params:{user: {name: "okayama",
                                           email: "daitokai@gmail.com",
                                           password: "",
                                           password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "okayama", @user.name
    assert_equal "daitokai@gmail.com", @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    patch user_path(@user), params:{user: {name: "okayama",
                                           email: "daitokai@gmail.com",
                                           password: "",
                                           password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "okayama", @user.name
    assert_equal "daitokai@gmail.com", @user.email
  end

end
