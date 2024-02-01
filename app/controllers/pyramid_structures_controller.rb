class PyramidStructuresController < ApplicationController
  before_action :pyramid_structure_params

  def update
    @selected_memo = @memos.find_by(id: params[:id])

    if @title.present? && @elements.present? && @basises.present? && @elements.size == @basises.size
      ActiveRecord::Base.transaction do
        @selected_memo.update!(title: @title)
        (0..2).each do |i|
          @selected_memo.explanations[i].update!(element: @elements[i], basis: @basises[i]) if @selected_memo.explanations[i].present?
        end
      end
      redirect_to memo_path(@selected_memo), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'memos/index', status: :unprocessable_entity
    end
  end

  private

  def pyramid_structure_params
    @title = params[:memo][:title]
    @elements = {}
    @basises = {}
    element_index = 0
    basis_index = 0
    params[:memo].each do |key, value|
      if key.to_s == "element_#{element_index}"
        @elements[element_index] = value if params["element_#{element_index}"].present?
        element_index += 1
      elsif key.to_s == "basis_#{basis_index}"
        @basises[basis_index] = value if params["basis_#{basis_index}"].present?
        basis_index += 1
      else
        next
      end
    end
  end
end
