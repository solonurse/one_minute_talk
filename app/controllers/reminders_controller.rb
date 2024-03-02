class RemindersController < ApplicationController
  before_action :reminder_params

  def create
    if @schedule.present?
      reminder = Reminder.new(user_id: current_user.id, memo_id: session[:memo_id], start_at: @schedule, reminder: true)
      if reminder.save
        flash[:success] = 'リマインダーを登録しました'
      else
        flash[:danger] = 'リマインダーを登録できませんでした'
      end
      redirect_to memo_path(session[:memo_id])
    else
      redirect_to memo_path(session[:memo_id]), danger: '予定日を設定してください'
    end
  end

  def update
    if @schedule.present?
      reminder = Reminder.find_by(id: params[:id])
      if reminder.update(start_at: @schedule)
        flash[:success] = 'リマインダーを更新しました'
      else
        flash[:danger] = 'リマインダーを更新できませんでした'
      end
      redirect_to memo_path(session[:memo_id])
    else
      redirect_to memo_path(session[:memo_id]), danger: '予定日を設定してください'
    end
  end

  private

  def reminder_params
    @schedule = params[:reminder][:started_at]
  end
end
