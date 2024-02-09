class ExplanationsController < ApplicationController
  before_action :title_params
  before_action :elements_params, only: %i[element]
  before_action :element_checkbox_params, only: %i[basis]

  def element
    if @title.present? && @elements.present?
      render :element
    else
      flash.now[:danger] = t('.fail')
			render 'memos/new', status: :unprocessable_entity
    end
  end

  def basis
    if @title.present? && @checkbox_key.present? && @elements.present?
      @register_memo_form = RegisterMemoForm.new
    else
      @elements = params.select { |key, value| key.to_s.start_with?('element_') }
      flash.now[:danger] = t('.fail')
      render :element, status: :unprocessable_entity
    end
  end

  private

  def title_params
    @title = params[:title]
  end

  def elements_params
    # element_~関連のパラメーターを取得し、nilと空白の値を排除
    @elements = params.select { |key, value| key.to_s.start_with?('element_') && !value.nil? && !value.blank? }
  end

  def element_checkbox_params
    # チェックボックスのキーを取得
    @checkbox_key = params.keys.select { |key| key.to_s.start_with?('checkbox_') && params[key].to_i == 1 }
    # チェックボックスのキーの数字を取得
    @checkbox_num = @checkbox_key.map { |key| key.to_s.gsub('checkbox_', '')}

    # チェックボックスと同じ数字のelement_キーを取得
    @elements = {}
    index = 0
    @checkbox_num.each do |num|
      @elements[index] = params["element_#{num}"] if params["element_#{num}"].present?
      index +=1
    end
  end
end
