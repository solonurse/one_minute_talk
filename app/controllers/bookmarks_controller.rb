class BookmarksController < ApplicationController
  def create
    @memo = Memo.find(params[:memo_id])
    current_user.bookmark(@memo)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("bookmark-button-for-memo-#{@memo.id}", partial: "memos/unbookmark", locals: {memo: @memo}),
          turbo_stream.replace("slidebar-bookmark-button-for-memo-#{@memo.id}", partial: "memos/slidebar/slidebar_unbookmark", locals: {memo: @memo})
        ]
      end
    end
  end

  def destroy
    @memo = current_user.bookmarks.find(params[:id]).memo
    current_user.unbookmark(@memo)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("unbookmark-button-for-memo-#{@memo.id}", partial: "memos/bookmark", locals: {memo: @memo}),
          turbo_stream.replace("slidebar-unbookmark-button-for-memo-#{@memo.id}", partial: "memos/slidebar/slidebar_bookmark", locals: {memo: @memo})
        ]
      end
    end
  end

  # def create_slidebar
  #   @memo = Memo.find(params[:memo_id])
  #   current_user.bookmark(@memo)
  # end

  # def destroy_slidebar
  #   @memo = current_user.bookmarks.find(params[:id]).memo
  #   current_user.unbookmark(@memo)
  # end
end
