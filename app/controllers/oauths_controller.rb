class OauthsController < ApplicationController
  skip_before_action :require_login
  def oauth
    #指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(provider))
      redirect_to memos_path, success:"#{provider.titleize}アカウントでログインしました"
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        signup_and_login(provider)
        redirect_to memos_path, success:"#{provider.titleize}アカウントでログインしました"
      rescue
        redirect_to login_path, danger:"#{provider.titleize}アカウントでのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end

  # def oauth
  #   # 指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
  #   login_at(auth_params[:provider])
  # end

  # def callback
  #   provider = auth_params[:provider]
  #   notice_message = "#{provider.titleize}アカウントでログインしました"

  #   # ログインを試みる
  #   @user = login_from(provider)
  #   unless @user
  #     # プロバイダ情報の取得
  #     sorcery_fetch_user_hash(provider)
  #     # 既存のユーザーを探す
  #     @user = User.find_by(email: @user_hash[:user_info]['email'])

  #     if @user
  #       # 既存のユーザーにプロバイダ情報を追加
  #       @user.add_provider_to_user(provider, @user_hash[:uid].to_s)
  #     else
  #       # 新しいユーザーを作成
  #       @user = create_from(provider)
  #     end

  #     reset_session
  #     auto_login(@user)
  #   end

  #   redirect_to mypage_path, success: notice_message
  # rescue StandardError
  #   redirect_to login_path, danger: "#{provider.titleize}アカウントでのログインに失敗しました"
  # end

  # private

  # def auth_params
  #   params.permit(:code, :provider)
  # end
end
