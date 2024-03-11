require 'rails_helper'

RSpec.describe "Schedules", type: :system do
  let(:memo) { create(:memo, :with_explanation_and_example) }

  before do
    driven_by(:rack_test)

    login_as(memo.user)
    visit memo_path(memo.id)
    fill_in 'reminder[started_at_date]', with: Time.current.strftime('%Y-%m-%d')
    fill_in 'reminder[started_at_time]', with: Time.current.strftime('%H:%M')
    check 'reminder[reminder]'
    click_button '保存'
  end

  describe 'スケジュール画面' do
    before do
      visit memos_path
    end

    it 'リマインダー登録したメモのタイトルとリンクがカレンダーに表示される' do
      within ".memo-container" do
        expect(page).to have_link memo.title, href: memo_path(memo.id)
      end
    end

    it 'メモのタイトルをクリックするとメモの詳細画面に遷移する' do
      within ".memo-container" do
        click_link memo.title
      end
      expect(current_path).to eq memo_path(memo.id)
    end
  end
end
