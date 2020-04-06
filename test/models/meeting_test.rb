require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:test_user)
    @meeting = Meeting.new(title: "Test-title", content: "Test-detail", 
                     start_time: "2020-04-02 07:47:30" , user_id: @user.id)
  end
  
  test "セットアップしたミーティングデータが有効であることのテスト" do
    assert @meeting.valid?
  end
  
  test "空白のタイトルは存在できないことのテスト" do
    @meeting.title = "  "
    assert_not @meeting.valid?
  end
  
  test "空白のコンテンツは存在できないことのテスト" do
    @meeting.content = "  "
    assert_not @meeting.valid?
  end
  
  test "登録時間が空白のミーティングは存在できないことのテスト" do
    @meeting.start_time = "  "
    assert_not @meeting.valid?
  end
  
  test "ミーティングのデータはユーザーと紐づいていることをテスト" do
    @meeting.user_id = "  "
    assert_not @meeting.valid?
  end

  
  test "タイトルは30文字まで有効であることのテスト" do
    @meeting.title = "a" * 31
    assert_not @meeting.valid?
  end
  
  test "コンテンツは200文字まで有効であることのテスト" do
    @meeting.content = "a" * 201
    assert_not @meeting.valid?
  end
  
end
