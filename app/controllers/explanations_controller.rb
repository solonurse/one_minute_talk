class ExplanationsController < ApplicationController
  def element
    @title = params[:title]
    # element_~関連のパラメーターを取得
    @elements = params.select { |key, value| key.to_s.start_with?('element_') }
    # nilまたは空白の値を削除
    @elements.reject! { |key, value| value.nil? || value.blank? }

    if @title.present? && @elements.present?
      render :element
    else
      flash.now[:danger] = t('.fail')
			render 'memos/new', status: :unprocessable_entity
    end
  end

  def basis
  end
end
