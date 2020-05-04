require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = users(:test_user)
    @non_admin = users(:test_jiro)
    @not_activation = users(:test_goro)
  end

  test "管理者権限アカウントでは削除リンクが表示されること及びユーザー一覧がページネーションされていることをテスト" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    #アクティベーションしていないユーザーは含まれていないことを確認
    assert_select "a", {count: 0, text: @not_activation.name}
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: '削除'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "管理者権限でないユーザーは削除リンクが表示されないことをテスト" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: '削除', count: 0
  end
  
end
