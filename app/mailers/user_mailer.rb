class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント登録のお願い"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワード再設定のご連絡"
  end
  
end
