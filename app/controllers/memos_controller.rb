class MemosController < ApplicationController
  def index
  end

  def new
    @memo = Memo.new
    @explanation = Explanation.new
  end

  def create
  end
end
