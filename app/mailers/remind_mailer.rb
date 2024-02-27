class RemindMailer < ApplicationMailer
  def remind_event_email(event)
    # メールの文章を作成するときに使用
    @event = event

    mail(to: event.user.email, subject: '明日の予定をお知らせします')
  end
end
