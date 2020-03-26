require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:test_user)
    remember(@user)
  end

  test "current_userメソッドが正しいユーザーでログインもされていることをテスト" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "remember_digestの値が誤っているとき、current_userはnilになることをテスト" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end