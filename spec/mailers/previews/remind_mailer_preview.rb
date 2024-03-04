# Preview all emails at http://localhost:3000/rails/mailers/remind_mailer
class RemindMailerPreview < ActionMailer::Preview
  RemindMailer.remind_event_email
end
