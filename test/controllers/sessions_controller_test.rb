require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "loginの名前付きルートが有効かテスト" do
    get login_path
    assert_response :success
  end

end
