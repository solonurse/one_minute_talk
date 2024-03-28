class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  # パスワードリセット申請画面へレンダリング
  def new; end

  # パスワードのリセットフォーム画面へ遷移するアクション
  def edit
    @token = params[:id]
    # トークン情報をもとにユーザーの照合を行う
    @user = User.load_from_reset_password_token(@token)
    # ユーザーが見つからなければ、ログインページに戻る
    not_authenticated if @user.blank?
  end

  # パスワードのリセットを要求するアクション
  def create
    @user = User.find_by(email: params[:email])

    # パスワードをリセットする方法を説明した電子メールをユーザーに送信
    # ユーザがいなければnilを返す
    @user&.deliver_reset_password_instructions!

    redirect_to login_path, success: t('.success')
  end

  # ユーザーがパスワードのリセットフォームを送信したときに発生
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticated if @user.blank?

    # 確認用のパスワードが正しく入力されたかどうかを確認
    @user.password_confirmation = params[:user][:password_confirmation]
    update_password
  end

  private

  def update_password
    # 一時トークンをクリアし、パスワードを更新
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end
end
