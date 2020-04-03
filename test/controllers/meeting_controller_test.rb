require 'test_helper'

class MeetingControllerTest < ActionDispatch::IntegrationTest
  def setup
    @meeting = meetings(:scheduleone)
  end

  test "ログインしていないとスケジュールの登録ができないことをテスト" do
    assert_no_difference 'Meeting.count' do
      post schedule_path, params: { meeting: { title: "test-title",
                                               content: "test-content",
                                               user_id: @meeting.user_id,
                                               start_time: "2020-04-05 07:39:32"
                                               } }
    end
    assert_redirected_to login_url
  end

  test "ログインしていないとスケジュールの削除ができないことをテスト" do
    assert_no_difference 'Meeting.count' do
      delete meeting_path(@meeting)
    end
    assert_redirected_to login_url
  end
end
