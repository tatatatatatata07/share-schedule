require 'test_helper'

class TopPagesControllerTest < ActionDispatch::IntegrationTest
  test "ルートへのgetリクエストが成功することをテスト" do
    get root_path
    assert_response :success
  end

end
