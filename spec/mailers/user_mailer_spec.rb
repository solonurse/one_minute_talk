require 'rails_helper'

RSpec.describe "UserMailer", type: :mailer do
  describe "パスワードリセットメール" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.reset_password_email(user) }
    before do
      user.generate_reset_password_token!
      mail.deliver_now
    end

    describe "メール送信" do
      it 'ヘッダー情報,ボディ情報が正しい' do
        expect(mail.subject).to eq 'パスワードリセット'
        expect(mail.to).to eq [user.email]
        expect(mail.from).to eq ['OneMinuteTalk@gmail.com']
      end

      it 'メール本文が正しい' do
        expect(mail.html_part.body.to_s).to have_content "john様"
        expect(mail.html_part.body.to_s).to have_content 'パスワード再発行のご依頼を受け付けました。'
        expect(mail.html_part.body.to_s).to have_content '以下のリンクからパスワードの再発行を行ってください。'
        expect(mail.text_part.body.to_s).to have_content 'http://localhost:3000/password_resets/'
      end
    end
  end
end
