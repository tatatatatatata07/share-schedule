require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:test_user)
    @other_user = users(:test_jiro)
  end
  
  test "signup_pathが使えることをテスト" do
    get signup_path
    assert_response :success
  end
  
  test "ログインしていない状態ではユーザー一覧へ遷移できないことをテスト" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "ログインせずにアカウント編集ページへ遷移できないことをテスト" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインせずにアカウント情報を更新できないことをテスト" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "ログインしていないとユーザーを削除できないことをテスト" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "管理者権限を持つユーザーでログインしないとユーザーを削除できないことをテスト" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
  test "フォロー一覧を表示する際にログインしていないとリダイレクトされることをテスト" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "フォロワー一覧を表示する際にログインしていないとリダイレクトされることをテスト" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end

end
