class PyramidStructuresController < ApplicationController
  before_action :pyramid_structure_params

  def update
    @selected_memo = @memos.find_by(id: params[:id])

    if @title.present? && @elements.present? && @basises.present? && @elements.size == @basises.size
      update_memo_structure
      redirect_to memo_path(@selected_memo), success: t('.success')
    else
      redirect_to memo_path(@selected_memo), danger: t('.fail')
    end
  end

  private

  def update_memo_structure
    ActiveRecord::Base.transaction do
      @selected_memo.update!(title: @title)
      @selected_memo.explanations.each_with_index do |explanation, i|
        explanation.update!(element: @elements[i], basis: @basises[i]) if explanation.present?
      end
    end
  end

  def pyramid_structure_params
    @title = params[:memo][:title]
    @elements = {}
    @basises = {}
    element_index = 0
    basis_index = 0
    params[:memo].each do |key, value|
      next unless key.to_s.start_with?("element_", "basis_")

      if key.to_s == "element_#{element_index}"
        @elements[element_index] = value if params[:memo]["element_#{element_index}"].present?
        element_index += 1
      else
        @basises[basis_index] = value if params[:memo]["basis_#{basis_index}"].present?
        basis_index += 1
      end
    end
  end
end
