class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_memos
  skip_before_action :set_bookmark_memos

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # User.newで作られたparams[:user]からemail、password、password_confirmation、nameだけを受け取るようにする。
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :salt)
  end
end
