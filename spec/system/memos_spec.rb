require 'rails_helper'

RSpec.describe "Memos", type: :system do
  let(:memo) { create(:memo, :with_explanation_and_example) }

  before do
    driven_by(:rack_test)

    login_as(memo.user)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"

  describe 'メモ詳細' do
    before do
      visit memo_path(memo.id)
    end
    
    describe 'ピラミッドストラクチャーの変更' do
      it '主張、要素、根拠がある場合、編集を保存できる' do
        fill_in 'memo[title]', with: 'title'
        fill_in 'memo[element_0]', with: 'element'
        fill_in 'memo[basis_0]', with: 'basis'
        click_button '編集を保存する'
        expect(page).to have_content "メモを更新しました"
        expect(current_path).to eq memo_path(memo.id)
      end

      it '主張がない場合は編集を保存に失敗する' do
        fill_in 'memo[title]', with: ''
        fill_in 'memo[element_0]', with: 'element'
        fill_in 'memo[basis_0]', with: 'basis'
        click_button '編集を保存する'
        expect(page).to have_content "主張、要素、根拠は全て入力してください"
      end

      it '要素がない場合は編集を保存に失敗する' do
        fill_in 'memo[title]', with: 'title'
        fill_in 'memo[element_0]', with: ''
        fill_in 'memo[basis_0]', with: 'basis'
        click_button '編集を保存する'
        expect(page).to have_content "主張、要素、根拠は全て入力してください"
      end

      it '根拠がない場合は編集を保存に失敗する' do
        fill_in 'memo[title]', with: 'title'
        fill_in 'memo[element_0]', with: 'element'
        fill_in 'memo[basis_0]', with: ''
        click_button '編集を保存する'
        expect(page).to have_content "主張、要素、根拠は全て入力してください"
      end
    end

    describe '例文の変更' do
      it '300文字以内の場合は編集を保存できる' do
        fill_in 'example[sentence]', with: 'sentence_test'
        click_button '例文を保存する'
        expect(page).to have_content "例文を更新しました"
        expect(current_path).to eq memo_path(memo.id)
      end

      it '300文字を超えた場合は編集を保存に失敗する' do
        long_sentence = Faker::Lorem.characters(number: 301)
        fill_in 'example[sentence]', with: long_sentence
        click_button '例文を保存する'
        expect(page).to have_content "例文は300文字以内で入力してください"
      end
    end
  end

  describe 'メモの新規作成' do
    before do
      visit new_memo_path
      fill_in 'title', with: 'new_memo_title'
      fill_in 'element_1', with: 'new_memo_element'
      click_button '次へ'
    end

    it 'メモの新規作成が成功すると例文が作成される' do
    end

    it '主張がない場合は新規作成に失敗する' do
    end

    it '要素がない場合は新規作成に失敗する' do
    end

    it '根拠がない場合は新規作成に失敗する' do
    end
  end

  # describe 'メモの編集' do
  #   it 'メモの編集が成功すると例文が作成される' do
  #   end

  #   it '主張がない場合は編集に失敗する' do
  #   end

  #   it '要素がない場合は編集に失敗する' do
  #   end

  #   it '根拠がない場合は編集に失敗する' do
  #   end
  # end

  # describe 'ブックマーク' do
  #   it 'ブックマークボタンを押すとメモがブックマーク済みになる' do
  #   end

  #   it 'ブックマーク済みボタンを押すとブックマークが解除される' do
  #   end
  # end
end
