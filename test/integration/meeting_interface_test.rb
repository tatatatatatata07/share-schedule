require 'test_helper'

class MeetingInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_jiro)
    @admin_user = users(:test_user)
  end

  test "通常ユーザーのみんなのスケジュールのインターフェーステスト" do
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
    follow_redirect!
    assert_match title, response.body
    # スケジュールの詳細ページの表示
    first_meeting = @user.meeting.first
    other_meeting = @admin_user.meeting.first
    #自分が作成したミーティングの詳細ページに「編集」「削除」リンクがあることを確認
    #自分のミーティングは削除できることを確認
    get meeting_path(first_meeting)
    assert_select 'a', text: '予定を編集する'
    assert_select 'a', text: '予定を削除する'
    assert_difference 'Meeting.count', -1 do
      delete meeting_path(first_meeting)
    end
    #違うユーザーが作成したミーティングの詳細ページに「編集」「削除」リンクがないことを確認
    #違うユーザーのミーティングは削除できないことを確認
    get meeting_path(other_meeting)
    assert_select 'a', text: '予定を編集する', count: 0
    assert_select 'a', text: '予定を削除する', count: 0
    assert_difference 'Meeting.count', 0 do
      delete meeting_path(other_meeting)
    end
  end
  
  test "管理者権限ユーザーのみんなのスケジュールのインターフェーステスト" do
    log_in_as(@admin_user)
    get meeting_index_path
    
    admin_meeting = @admin_user.meeting.first    
    non_admin_meeting = @user.meeting.first
    
    #自分が作成したミーティングの詳細ページに「編集」「削除」リンクがあることを確認
    #自分が作成したミーティングは削除できることを確認
    get meeting_path(admin_meeting)
    assert_select 'a', text: '予定を編集する'
    assert_select 'a', text: '予定を削除する'
    assert_difference 'Meeting.count', -1 do
      delete meeting_path(admin_meeting)
    end
    #違うユーザーが作成したミーティングの詳細ページに「編集」「削除」リンクがあることを確認
    #管理者ユーザーは他人のミーティングを削除できることを確認
    get meeting_path(non_admin_meeting)
    assert_select 'a', text: '予定を編集する'
    assert_select 'a', text: '予定を削除する'
    assert_difference 'Meeting.count', -1 do
      delete meeting_path(non_admin_meeting)
    end
  end
  
end
