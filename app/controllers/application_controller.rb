class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_memos
  before_action :set_bookmark_memos

	private

	def not_authenticated
    redirect_to login_path, danger: "ログインしてください"
  end

  def set_memos
    @memos = current_user.memos.includes(:explanations, :example).order(created_at: :desc) if logged_in?
  end

  def set_bookmark_memos
    @bookmark_memos = current_user.bookmark_memos.order(created_at: :desc) if logged_in?
  end
end
