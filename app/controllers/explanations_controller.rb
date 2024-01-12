class ExplanationsController < ApplicationController
  before_action :title_params

  def element
    elements_params

    if @title.present? && @elements.present?
      render :element
    else
      flash.now[:danger] = t('.fail')
			render 'memos/new', status: :unprocessable_entity
    end
  end

  def basis
    # チェックボックスのキーを取得
    checkbox_key = params.keys.select { |key| key.to_s.start_with?('checkbox_') && params[key].to_i == 1 }
    # チェックボックスのキーの数字を取得
    checkbox_num = checkbox_key.map { |key| key.to_s.gsub('checkbox_', '')}

    if @title.present? && checkbox_key.present?
      @register_memo_form = RegisterMemoForm.new
      @elements = {}
      # チェックボックスと同じ数字のelementキーを取得
      checkbox_num.each do |num|
        @elements[num] = params["element_#{num}"] if params["element_#{num}"].present?
      end
    else
      elements_params
      flash.now[:danger] = t('.fail')
      render :element, status: :unprocessable_entity
    end
  end

  private

  def title_params
    @title = params[:title]
  end

  def elements_params
    # element_~関連のパラメーターを取得
    @elements = params.select { |key, value| key.to_s.start_with?('element_') }
    # nilまたは空白の値を削除
    @elements.reject! { |key, value| value.nil? || value.blank? }
  end
end
