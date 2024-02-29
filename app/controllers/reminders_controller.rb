class RemindersController < ApplicationController
  before_action :reminder_params

  def create
    
  end

  def update
  end

  private

  def reminder_params
    @time = params.require(:reminder).permit(:started_at)
    @memo = Reminder.find(params[:id]).memo
  end
end
