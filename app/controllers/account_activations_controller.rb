class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "アクティベーションが完了しました。"
      redirect_to user
    else
      flash[:danger] = "申し訳ございません。URLが有効でないためもう一度最初から登録をお願いします。"
      redirect_to root_url
    end
  end
end
