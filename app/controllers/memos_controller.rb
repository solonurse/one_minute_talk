class MemosController < ApplicationController
  before_action :set_memos, only: %i[index show]
  before_action :set_bookmark_memos, only: %i[index show]

  def index; end

  def new; end

  def show
    @selected_memo = @memos.find_by(id: params[:id])
    render :index
  end

  def create
    @register_memo_form = RegisterMemoForm.new(register_memo_params)

    if @register_memo_form.save
      redirect_to memos_path, success: t('.success')
    else
      save_failed_memo_params
      flash.now[:danger] = t('.fail')
      render 'explanations/basis', status: :unprocessable_entity
    end
  end

  def destroy
    @memo = current_user.memos.find(params[:id])
    @memo.destroy!
    redirect_to memos_path, success: t('.success'), status: :see_other
  end

  private

  def set_memos
    @memos = current_user.memos.all.includes(:explanations).order(created_at: :desc)
  end

  def set_bookmark_memos
    @bookmark_memos = current_user.bookmark_memos.all.order(created_at: :desc)
  end

  def register_memo_params
    params.require(:register_memo_form).permit(:title, :element_0, :element_1, :element_2, :basis_0, :basis_1, :basis_2).merge(user_memo_id: current_user.id)
  end

  def save_failed_memo_params
    @title = params[:register_memo_form][:title]
    @elements = {}
    index = 0
    params[:register_memo_form].each do |key, value|
      if key.to_s.start_with?('element_')
        @elements[index] = params[:register_memo_form]["element_#{index}"]
        index += 1
      end
    end
  end
end
