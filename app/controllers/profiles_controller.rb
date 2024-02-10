class ProfilesController < ApplicationController
  before_action :set_user
  skip_before_action :set_memos, only: %i[update]
  skip_before_action :set_bookmark_memos, only: %i[update]

  def edit; end

  def update
    if @user.update(profile_params)
      redirect_to memos_path, success: t('.updated')
    else
      flash.now[:danger] = t('.update_failed')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:name, :email)
  end
end
