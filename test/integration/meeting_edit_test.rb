require 'test_helper'

class MeetingEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:test_jiro)
    @first_meeting = @user.meeting.first
  end
  
  test "無効な値でスケジュールの変更をテスト" do
    log_in_as(@user)
    get edit_meeting_path(@first_meeting)
    assert_template 'meeting/edit'
    patch meeting_path(@first_meeting), params: { meeting: { title:  "",
                                                              contet: "",
                                                              start_date: "",
                                                              start_hour: "",
                                                              start_minute: "",} }
    assert_template 'meeting/edit'
  end
  
  test "有効な値でスケジュールの変更をテスト" do
    log_in_as(@user)
    get edit_meeting_path(@first_meeting)
    title = "Update title"
    content = "Update content"
    start_date = "2020-04-05"
    start_hour = "10"
    start_minute = "20"
    patch meeting_path(@first_meeting), params: { meeting: { title:  title,
                                                              content: content,
                                                              start_date: start_date,
                                                              start_hour: start_hour,
                                                              start_minute: start_minute,} }
    assert_not flash.empty?
    assert_redirected_to meeting_index_path
    @first_meeting.reload
    assert_equal title,  @first_meeting.title
    assert_equal content, @first_meeting.content
    start_time = start_date + " " + start_hour + ":" + start_minute
    assert_equal start_time, @first_meeting.start_time.to_s[0,16]
  end
  
end
