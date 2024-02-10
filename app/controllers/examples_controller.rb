class ExamplesController < ApplicationController
  skip_before_action :set_memos
  skip_before_action :set_bookmark_memos

  def update
    sentence = Example.find_by(id: params[:id])
    memo = sentence.memo
    if sentence.update(sentence_params)
      redirect_to memo_path(memo), success: t('.success')
    else
      redirect_to memo_path(memo), danger: t('.fail')
    end
  end

  private

  def sentence_params
    params.require(:example).permit(:sentence)
  end
end
