class BookmarksController < ApplicationController
  def create
    @memo = current_user.memos.find(params[:memo_id])
    current_user.bookmark(@memo)
    @bookmark_memos = current_user.bookmark_memos.all.order(created_at: :desc)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("bookmark-button-for-memo-#{@memo.id}", partial: "memos/unbookmark", locals: {memo: @memo}),
          turbo_stream.replace("slidebar-bookmark-button-for-memo-#{@memo.id}", partial: "memos/slidebar/slidebar_unbookmark", locals: {memo: @memo}),
          turbo_stream.replace("bookmarked-memo", partial: "memos/bookmarked_memo", locals: {bookmark_memos: @bookmark_memos}),
        ]
      end
    end
  end

  def destroy
    @memo = current_user.bookmarks.find(params[:id]).memo
    current_user.unbookmark(@memo)
    @bookmark_memos = current_user.bookmark_memos.all.order(created_at: :desc)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("unbookmark-button-for-memo-#{@memo.id}", partial: "memos/bookmark", locals: {memo: @memo}),
          turbo_stream.replace("slidebar-unbookmark-button-for-memo-#{@memo.id}", partial: "memos/slidebar/slidebar_bookmark", locals: {memo: @memo}),
          turbo_stream.replace("bookmarked-memo", partial: "memos/bookmarked_memo", locals: {bookmark_memos: @bookmark_memos}),
        ]
      end
    end
  end
end
