require 'test_helper'

class MeetingInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
  end

  test "みんなのスケジュールのインターフェーステスト" do
    log_in_as(@user)
    get meeting_index_path
    assert_select 'div.pagination'
    # 無効なパラメータを送信
    assert_no_difference 'Meeting.count' do
      post schedule_path, params: { meeting: { content: "", title: "", start_date: DateTime.now.to_s[0,10], start_hour: "0", start_minute: "0"} }
    end
    assert_select 'div#error_explanation'
    # 有効なパラメータを送信
    title = "テスト"
    content = "テスト"
    start_date = DateTime.now.to_s[0,10]
    start_hour = "10"
    start_minute = "10"
    assert_difference 'Meeting.count', 1 do
      post schedule_path, params: { meeting: { title: title, content: content, start_date: start_date, start_hour: start_hour, start_minute: start_minute } }
    end
    #debugger
    #時間区切りができていないため未実装 もとのカレンダーの月へもどる
    #assert_redirected_to meeting_index_path
    follow_redirect!
    assert_match title, response.body
    
    # スケジュールの削除
    assert_select 'a', text: '削除'
    first_meeting = @user.meeting.first
    assert_difference 'Meeting.count', -1 do
      delete meeting_path(first_meeting)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認) 未実装
    #get user_path(users(:archer))
    #assert_select 'a', text: 'delete', count: 0
  end
end
