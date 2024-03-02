class MemosController < ApplicationController
  skip_before_action :set_memos, only: %i[destroy]
  skip_before_action :set_bookmark_memos, only: %i[update destroy]

  def index; end

  def show
    @selected_memo = @memos.find_by(id: params[:id])
    
    session[:memo_id] = nil if session[:memo_id].present?
    session[:memo_id] = @selected_memo.id
    if @selected_memo.reminder.present?
      @reminder = @selected_memo.reminder
      @start_time = @reminder.start_at
    else
      @reminder = Reminder.new
    end

    example_data = @selected_memo&.example || { sentence: "" }
    @example_sentence = example_data[:sentence]
    @example_length = @example_sentence.length
    @speaking_time = (@example_length / 300.to_f * 60).round
    render :index
  end

  def new; end

  def edit
    @register_memo_form = RegisterMemoForm.new
    @memo = @memos.find_by(id: params[:id])
    @title = @memo.title
    @memo_explanations = @memo.explanations
    @elements = {}
    @basises = {}
    3.times do |i|
      if @memo_explanations[i]
        @elements[i] = @memo_explanations[i].element.presence || ''
        @basises[i] = @memo_explanations[i].basis.presence || ''
      end
    end
  end

  def create
    @register_memo_form = RegisterMemoForm.new(register_memo_params)

    if @register_memo_form.save
      redirect_to memos_path, success: t('.success')
    else
      save_failed_memo_params
      flash.now[:danger] = @register_memo_form.chatgpt_error_message.present? ? t('.example_fail') : t('.fail')
      render 'explanations/basis', status: :unprocessable_entity
    end
  end

  def update
    @register_memo_form = RegisterMemoForm.new(update_memo_params)

    if @register_memo_form.update
      redirect_to memos_path, success: t('.success')
    else
      update_failed_memo_params
      flash.now[:danger] = @register_memo_form.chatgpt_error_message.present? ? t('.example_fail') : t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @memo = current_user.memos.find(params[:id])
    @memo.destroy!
    redirect_to memos_path, success: t('.success'), status: :see_other
  end

  private

  def register_memo_params
    params.require(:register_memo_form).permit(:title, :element_0, :element_1, :element_2, :basis_0, :basis_1, :basis_2).merge(user_id: current_user.id)
  end

  def save_failed_memo_params
    @title = params[:register_memo_form][:title]
    @elements = {}
    index = 0
    params[:register_memo_form].each_key do |key|
      if key.to_s.start_with?('element_')
        @elements[index] = params[:register_memo_form]["element_#{index}"]
        index += 1
      end
    end
  end

  def update_memo_params
    params.require(:register_memo_form).permit(:title, :element_0, :element_1, :element_2, :basis_0, :basis_1, :basis_2).merge(user_id: current_user.id, memo_id: params[:id])
  end

  def update_failed_memo_params
    @memo = @memos.find_by(id: params[:id])
    @title = params[:register_memo_form][:title]
    @elements = {}
    @basises = {}
    element_index = 0
    basis_index = 0
    params[:register_memo_form].each do |key, value|
      if key.to_s == "element_#{element_index}"
        @elements[element_index] = value
        element_index += 1
      elsif key.to_s == "basis_#{basis_index}"
        @basises[basis_index] = value
        basis_index += 1
      else
        next
      end
    end
  end
end
