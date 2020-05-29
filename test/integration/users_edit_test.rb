require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:test_user)
    @trial_user = users(:test_gest)
  end
  
  test "お試しログインユーザーではアカウント更新ができないことをテスト" do
    log_in_as(@trial_user)
    get edit_user_path(@trial_user)
    assert_redirected_to root_url
    first_name  = "test"
    last_name = "user2"
    email = "xyz@example.com"
    patch user_path(@trial_user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_redirected_to root_url
    @trial_user.reload
    assert_equal "ゲスト",  @trial_user.name
    assert_equal "gest@example.com", @trial_user.email
  end

  test "無効な値でアカウント情報を更新しようとしたときの挙動をテスト" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    
  end
  
  test "有効な値でアカウント情報を更新しようとしたときの挙動をテスト" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    first_name  = "test"
    last_name = "user2"
    email = "xyz@example.com"
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal "test user2",  @user.name
    assert_equal email, @user.email
  end
  
end
