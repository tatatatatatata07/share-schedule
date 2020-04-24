require 'test_helper'

class MeetingControllerTest < ActionDispatch::IntegrationTest
  def setup
    @meeting = meetings(:one)
  end

  test "ログインしていないとスケジュールの登録ができないことをテスト" do
    assert_no_difference 'Meeting.count' do
      post schedule_path, params: { meeting: { title: "test-title",
                                               content: "test-content",
                                               user_id: @meeting.user_id,
                                               start_date: "2020-04-24",
                                               start_hour: "10",
                                               start_minute: "20" }} 
    end
    assert_redirected_to login_url
  end

  test "ログインしていないとスケジュールの変更ができないことをテスト" do
    patch meeting_path(@meeting), params: { meeting: { title: "test-title",
                                                       content: "test-content",
                                                       user_id: @meeting.user_id,
                                                       start_date: "2020-04-24",
                                                       start_hour: "10",
                                                       start_minute: "20" }}  
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "管理者以外のユーザーは自分のスケジュール以外変更できないことをテスト" do
    log_in_as(users(:test_jiro))
    patch meeting_path(@meeting), params: { meeting: { title: "test-title",
                                                       content: "test-content",
                                                       user_id: @meeting.user_id,
                                                       start_date: "2020-04-24",
                                                       start_hour: "10",
                                                       start_minute: "20" }}   
    assert_redirected_to root_url
  end

  test "ログインしていないとスケジュールの削除ができないことをテスト" do
    assert_no_difference 'Meeting.count' do
      delete meeting_path(@meeting)
    end
    assert_redirected_to login_url
  end
  
  test "管理者以外のユーザーは自分のスケジュール以外削除できないことをテスト" do
    log_in_as(users(:test_jiro))
    assert_no_difference 'Meeting.count' do
      delete meeting_path(@meeting)
    end
    assert_redirected_to root_url
  end
end
