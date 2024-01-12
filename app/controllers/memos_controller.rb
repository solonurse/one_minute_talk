class MemosController < ApplicationController
  # before_action :memo_params, only: %i[create]

  def index
    @memos = current_user.memos.all.includes(:explanations).order(created_at: :desc)
  end

  def new; end

  def create
    register_memo_form = RegisterMemoForm.new(register_memo_params)

    if register_memo_form.save
      redirect_to memos_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'explanations/basis', status: :unprocessable_entity
    end
  end

  private

  def register_memo_params
    register_element_keys = params.select { |key, value| key.to_s.start_with?('register_memo_form[element_') }.transform_keys(&:to_sym)
    register_basis_keys = params.select { |key, value| key.to_s.start_with?('register_memo_form[basis_') }.transform_keys(&:to_sym)

    params.require(:register_memo_form).permit(:title, register_element_keys, register_basis_keys).merge(user_memo_id: User.find(current_user.id))
  end
end
