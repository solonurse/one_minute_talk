class BookmarksController < ApplicationController
  def create
    memo = Memo.find(params[:memo_id])
    current_user.bookmark(memo)
    redirect_to memos_path
  end

  def destroy
    memo = current_user.bookmarks.find(params[:id]).memo
    current_user.unbookmark(memo)
    redirect_to memos_path
  end
end
