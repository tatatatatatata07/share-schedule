require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  test "アカウントのアクティベーションテスト" do
    user = users(:test_user)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "アカウント登録のお願い", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@share-schedule.com"], mail.from
    assert_match user.name,               mail.text_part.body.to_s.encode("UTF-8")
    assert_match user.activation_token,   mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email),  mail.text_part.body.to_s.encode("UTF-8")
  end
  
  test "アカウントのパスワードリセットテスト" do
    user = users(:test_user)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "パスワード再設定のご連絡", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@share-schedule.com"], mail.from
    assert_match user.reset_token,        mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email),  mail.text_part.body.to_s.encode("UTF-8")
  end
  
end
