require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  PER = 5

  def setup
    @admin = users(:test)
    @non_admin = users(:deputy)
  end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'nav.pagination'
      User.page(1).per(PER).each do |user|
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
         assert_select 'a[href=?]', user_path(user), text: '削除'
        end
      end
      assert_difference 'User.count', -1 do
        delete user_path(@non_admin)
      end
  end

  test "index non_admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: '削除', count: 0
  end

end
