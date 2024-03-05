require "rails_helper"

RSpec.describe RemindMailer, type: :mailer do
  describe 'リマインダーメール送信' do
    let(:reminder_later_day) { create(:reminder, :later_day) }

    it 'ヘッダー情報,ボディ情報が正しい' do
      RemindMailer.remind_event_email(reminder_later_day).deliver_now

      expect(ActionMailer::Base.deliveries.last.subject).to eq '明日の予定をお知らせします'
      expect(ActionMailer::Base.deliveries.last.to).to eq [reminder_later_day.user.email]
      expect(ActionMailer::Base.deliveries.last.from).to eq ['OneMinuteTalk@gmail.com']
    end

    it 'メール本文が正しい' do
      RemindMailer.remind_event_email(reminder_later_day).deliver_now

      expect(ActionMailer::Base.deliveries.last.html_part.body.to_s).to have_content "こんにちは#{reminder_later_day.user.name}"
      expect(ActionMailer::Base.deliveries.last.html_part.body.to_s).to have_content reminder_later_day.memo.title
      expect(ActionMailer::Base.deliveries.last.html_part.body.to_s).to have_content reminder_later_day.memo.example.sentence
      expect(ActionMailer::Base.deliveries.last.html_part.body.to_s).to have_content "開始予定日時：#{reminder_later_day.start_at.strftime('%Y/%m/%d %H:%M')}"
      expect(ActionMailer::Base.deliveries.last.html_part.body.to_s).to have_link('詳細を確認する', href: memo_url(reminder_later_day.memo.id))
    end
  end
end
