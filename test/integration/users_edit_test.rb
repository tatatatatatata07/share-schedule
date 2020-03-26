require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:test_user)
  end

  test "無効な値でアカウント情報を更新しようとしたときの挙動をテスト" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end
  
  test "有効な値でアカウント情報を更新しようとしたときの挙動をテスト" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "test_user2"
    email = "xyz@example.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
end
