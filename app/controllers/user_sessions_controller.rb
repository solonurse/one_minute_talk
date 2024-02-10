class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_memos
  skip_before_action :set_bookmark_memos
  
  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user
      redirect_to memos_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success'), status: :see_other
  end
end
