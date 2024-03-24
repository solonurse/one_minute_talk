class BookmarksController < ApplicationController
  skip_before_action :set_memos
  skip_before_action :set_bookmark_memos

  def create
    @memo = current_user.memos.find(params[:memo_id])
    current_user.bookmark(@memo)
    @bookmark_memos = current_user.bookmark_memos.order(created_at: :desc)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: respond_to_turbo_stream("bookmark-button-for-memo-#{@memo.id}",
                                                     "memos/unbookmark",
                                                     memo: @memo)
      end
    end
  end

  def destroy
    @memo = current_user.bookmarks.find(params[:id]).memo
    current_user.unbookmark(@memo)
    @bookmark_memos = current_user.bookmark_memos.order(created_at: :desc)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: respond_to_turbo_stream("unbookmark-button-for-memo-#{@memo.id}",
                                                     "memos/bookmark",
                                                     memo: @memo)
      end
    end
  end

  private

  def respond_to_turbo_stream(path, partial, locals)
    [turbo_stream.replace(path, partial:, locals:),
     turbo_stream.replace("slidebar-#{path}",
                          partial: "memos/slidebar/slidebar_#{partial.split('/').last}",
                          locals:),
     turbo_stream.replace("bookmarked-memo",
                          partial: "memos/bookmarked_memo",
                          locals: { bookmark_memos: @bookmark_memos }),
     turbo_stream.replace("bookmarked-slidebar-memo",
                          partial: "memos/slidebar/bookmarked_slidebar_memo",
                          locals: { bookmark_memos: @bookmark_memos })]
  end
end
