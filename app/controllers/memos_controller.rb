class MemosController < ApplicationController
  def index
  end

  def new
    # @memo = Memo.new
    # @explanation = Explanation.new
  end

  def create
    @title = params[:title]
    @elements = Array(params[:element]).map(&:strip).reject(&:empty?)

    # @elements.each do |element|
    #   @element_list += element unless element.nil? || element.strip.empty?
    # end

    render "element"
  end
end
