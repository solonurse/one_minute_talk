class Batch::RemindEvent
  def self.remind_event
    events = Reminder.all
    events.each do |event|
      # AM9:00との時間差を時間単位で算出する
      time_different = (event.start_at - Time.now.in_time_zone("Tokyo")) / 3600
      # 次の日のスケジュールなのかユーザーがリマインド機能をオンにしているかを判定
      if time_different <= 39 && time_different >= 15 && event.reminder == true
        # メールを送信
        RemindMailer.remind_event_email(event).deliver_now
      end
    end
  end
end