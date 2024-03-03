class RemindersController < ApplicationController
  before_action :reminder_params

  def create
    if @schedule.present? && @reminder_boolean_type == '1'
      reminder = Reminder.new(user_id: current_user.id, memo_id: session[:memo_id], start_at: @schedule, reminder: true)
      if reminder.save
        flash[:success] = t('.create_remidner_success')
      else
        flash[:danger] = t('.create_reminder_fail')
      end
    elsif @schedule.present? && @reminder_boolean_type == '0'
      reminder = Reminder.new(user_id: current_user.id, memo_id: session[:memo_id], start_at: @schedule, reminder: false)
      if reminder.save
        flash[:success] = t('.create_remidner_success')
      else
        flash[:danger] = t('.create_reminder_fail')
      end
    else
      flash[:danger] = t('.set_schedule')
    end
    redirect_to memo_path(session[:memo_id])
  end

  def update
    if @schedule.present? && @reminder_boolean_type == '1'
      reminder = Reminder.find_by(id: params[:id])
      if reminder.update(start_at: @schedule, reminder: true)
        flash[:success] = t('.update_remidner_success')
      else
        flash[:danger] = t('.update_reminder_fail')
      end
    elsif @schedule.present? && @reminder_boolean_type == '0'
      reminder = Reminder.find_by(id: params[:id])
      if reminder.update(start_at: @schedule, reminder: false)
        flash[:success] = t('.update_remidner_success')
      else
        flash[:danger] = t('.update_reminder_fail')
      end
    else
      flash[:danger] = t('.set_schedule')
    end
    redirect_to memo_path(session[:memo_id])
  end

  private

  def reminder_params
    @schedule = params[:reminder][:started_at]
    @reminder_boolean_type = params[:reminder][:reminder]
  end
end