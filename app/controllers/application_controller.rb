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
    @memos = current_user.memos.all.includes(:explanations).order(created_at: :desc)
  end

  def set_bookmark_memos
    @bookmark_memos = current_user.bookmark_memos.all.order(created_at: :desc)
  end
end
