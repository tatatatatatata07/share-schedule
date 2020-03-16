require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest
  test "layout links when not login" do
    
    get root_path
    assert_template 'top_pages/home'
    assert_select "title",title_name("")
  end
  
end
