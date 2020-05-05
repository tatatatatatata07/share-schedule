class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント登録のお願い", from: 'シェアスケジュール事務局 <noreply@share-schedule.com>'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワード再設定のご連絡", from: 'シェアスケジュール事務局 <noreply@share-schedule.com>'
  end
  
end
