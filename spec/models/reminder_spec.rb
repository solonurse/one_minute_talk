require 'rails_helper'

RSpec.describe Reminder, type: :model do
  
  context 'トグルスイッチがONの場合' do
    let(:reminder_on_start_at) { build(:reminder, :later_day) }
    it '予定日がある場合、登録できる' do
      expect(reminder_on_start_at).to be_valid
    end

    let (:reminder_on_without_start_at)  { build(:reminder, :later_day,start_at: nil)  }
    it '予定日がない場合、登録できない' do
      expect(reminder_on_without_start_at).to be_invalid
    end
  end

  context 'トグルスイッチがOFFの場合' do
    let(:reminder_off_start_at) { build(:reminder, :later_day_reminder_false) }
    it '予定日がある場合、登録できる' do
      expect(reminder_off_start_at).to be_valid
    end

    let(:reminder_off_without_start_at) { build(:reminder, :later_day_reminder_false, start_at: nil) }
    it '予定日がない場合、登録できない' do
      expect(reminder_off_without_start_at).to be_invalid
    end
  end
end
