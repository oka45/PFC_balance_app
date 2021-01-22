require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Shingo Oka", email: "user@example.com")
  end

  test "should be valid (バリテーションが有効か)" do
    assert @user.valid?
  end

  test "name should be present (名前が存在しているか)" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present (メールアドレスが存在しているか)" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long (名前の長さは50文字まで)" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long (メールアドレスの長さは255文字まで)" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses (有効なメールアドレスの検証)" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                first.last@foo.jp alice+bob@baz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} 有効なアドレスにしてください"
    end
  end

  test "email validation should reject invalid addresses (無効なメールアドレスの検証)" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} 無効なアドレスにしてください"
    end
  end

  test "email addresses should be unique (メールアドレスが一意であるか)" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
