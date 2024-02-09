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
    end
    
    describe '1ページ目' do
      context '伝えたいこと、伝えたい理由のフォームを入力' do
        it '2ページ目に遷移成功する' do
          fill_in 'title', with: 'new_memo_title'
          fill_in 'element_1', with: 'new_memo_element'
          click_button '次へ'
          expect(current_path).to eq explanations_element_path
        end  
      end

      context '伝えたいことのフォームが未入力' do
        it '2ページ目に遷移失敗する' do
          fill_in 'title', with: ''
          fill_in 'element_1', with: 'new_memo_element'
          click_button '次へ'
          expect(page).to have_content "あなたが伝えたいことと伝えたい理由を入力してください"
        end  
      end

      context '伝えたい理由のフォームが未入力' do
        it '2ページ目に遷移失敗する' do
          fill_in 'title', with: 'new_memo_title'
          fill_in 'element_1', with: ''
          click_button '次へ'
          expect(page).to have_content "あなたが伝えたいことと伝えたい理由を入力してください"
        end  
      end
    end

    describe '2ページ目' do
      before do
        fill_in 'title', with: 'new_memo_title'
        fill_in 'element_1', with: 'new_memo_element'
        click_button '次へ'
      end

      context '伝えたいこと、伝えたい理由、チェックボックスを入力' do
        it '3ページ目に遷移成功する' do
          fill_in 'title', with: 'new_memo_title'
          fill_in 'element_element_1', with: 'new_memo_element'
          check 'checkbox_element_1'
          click_button '次へ'
          expect(current_path).to eq explanations_basis_path
        end
      end

      context '伝えたいことのフォームが未入力' do
        it '3ページ目に遷移失敗する' do
          fill_in 'title', with: ''
          fill_in 'element_element_1', with: 'new_memo_element'
          check 'checkbox_element_1'
          click_button '次へ'
          expect(page).to have_content "あなたが伝えたいことを入力、また伝えたい理由の中から特に伝えたいものを選択してください"
        end
      end

      context '伝えたい理由のフォームが未入力' do
        it '3ページ目に遷移失敗する' do
          fill_in 'title', with: 'new_memo_title'
          fill_in 'element_element_1', with: ''
          check 'checkbox_element_1'
          click_button '次へ'
          expect(page).to have_content "あなたが伝えたいことを入力、また伝えたい理由の中から特に伝えたいものを選択してください"
        end
      end
    end

    describe '3ページ目' do
      before do
        fill_in 'title', with: 'new_memo_title'
        fill_in 'element_1', with: 'new_memo_element'
        click_button '次へ'
        fill_in 'title', with: 'new_memo_title'
        fill_in 'element_element_1', with: 'new_memo_element'
        check 'checkbox_element_1'
        click_button '次へ'
      end

      context '伝えたいこと、伝えたい理由、なぜ伝えたいのかを入力' do
        it 'メモが作成される' do
          fill_in 'register_memo_form[title]', with: 'new_memo_title'
          fill_in 'register_memo_form[element_0]', with: 'new_memo_element'
          fill_in 'register_memo_form[basis_0]', with: 'new_memo_basis'
          click_button '例文を作成する'
          expect(current_path).to eq memos_path
          expect(page).to have_content "メモを作成しました"
        end
      end
    
      context '伝えたいことのフォームが未入力' do
        it 'メモの作成に失敗する' do
          fill_in 'register_memo_form[title]', with: ''
          fill_in 'register_memo_form[element_0]', with: 'new_memo_element'
          fill_in 'register_memo_form[basis_0]', with: 'new_memo_basis'
          click_button '例文を作成する'
          expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
        end
      end

      context '伝えたい理由のフォームが未入力' do
        it 'メモの作成に失敗する' do
          fill_in 'register_memo_form[title]', with: 'new_memo_title'
          fill_in 'register_memo_form[element_0]', with: ''
          fill_in 'register_memo_form[basis_0]', with: 'new_memo_basis'
          click_button '例文を作成する'
          expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
        end
      end

      context 'なぜ伝えたいのかのフォームが未入力' do
        it 'メモの作成に失敗する' do
          fill_in 'register_memo_form[title]', with: 'new_memo_title'
          fill_in 'register_memo_form[element_0]', with: 'new_memo_element'
          fill_in 'register_memo_form[basis_0]', with: ''
          click_button '例文を作成する'
          expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
        end
      end

      context '伝えたい理由、なぜ伝えたいのかのフォームが未入力' do
        it 'メモの作成に失敗する' do
          fill_in 'register_memo_form[title]', with: 'new_memo_title'
          fill_in 'register_memo_form[element_0]', with: ''
          fill_in 'register_memo_form[basis_0]', with: ''
          click_button '例文を作成する'
          expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
        end
      end

      context '伝えたいこと、伝えたい理由、なぜ伝えたいのかのフォームが未入力' do
        it 'メモの作成に失敗する' do
          fill_in 'register_memo_form[title]', with: ''
          fill_in 'register_memo_form[element_0]', with: ''
          fill_in 'register_memo_form[basis_0]', with: ''
          click_button '例文を作成する'
          expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
        end
      end
    end
  end

  describe 'メモの編集' do
    before do
      visit edit_memo_path(memo.id)
    end

    context '伝えたいこと、伝えたい理由、なぜ伝えたいのかを入力' do
      it 'メモの編集に成功する' do
        fill_in 'register_memo_form[title]', with: 'edit_memo_title'
        fill_in 'register_memo_form[element_0]', with: 'edit_memo_element'
        fill_in 'register_memo_form[basis_0]', with: 'edit_memo_basis'
        click_button '例文を作成する'
        expect(current_path).to eq memos_path
        expect(page).to have_content "メモを更新しました"
      end
    end

    context '伝えたいことのフォームが未入力' do
      it 'メモの編集に失敗する' do
        fill_in 'register_memo_form[title]', with: ''
        fill_in 'register_memo_form[element_0]', with: 'edit_memo_element'
        fill_in 'register_memo_form[basis_0]', with: 'edit_memo_basis'
        click_button '例文を作成する'
        expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
      end
    end

    context '伝えたい理由のフォームが未入力' do
      it 'メモの編集に失敗する' do
        fill_in 'register_memo_form[title]', with: 'edit_memo_title'
        fill_in 'register_memo_form[element_0]', with: ''
        fill_in 'register_memo_form[basis_0]', with: 'edit_memo_basis'
        click_button '例文を作成する'
        expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
      end
    end

    context 'なぜ伝えたいのかのフォームが未入力' do
      it 'メモの編集に失敗する' do
        fill_in 'register_memo_form[title]', with: 'edit_memo_title'
        fill_in 'register_memo_form[element_0]', with: 'edit_memo_element'
        fill_in 'register_memo_form[basis_0]', with: ''
        click_button '例文を作成する'
        expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
      end
    end

    context '伝えたい理由、なぜ伝えたいのかのフォームが未入力' do
      it 'メモの編集に失敗する' do
        fill_in 'register_memo_form[title]', with: 'edit_memo_title'
        fill_in 'register_memo_form[element_0]', with: ''
        fill_in 'register_memo_form[basis_0]', with: ''
        click_button '例文を作成する'
        expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
      end
    end

    context '伝えたいこと、伝えたい理由、なぜ伝えたいのかのフォームが未入力' do
      it 'メモの編集に失敗する' do
        fill_in 'register_memo_form[title]', with: ''
        fill_in 'register_memo_form[element_0]', with: ''
        fill_in 'register_memo_form[basis_0]', with: ''
        click_button '例文を作成する'
        expect(page).to have_content "伝えたいこと、伝えたい理由、なぜ伝えたいのかをそれぞれ入力してください"
      end
    end
  end
end
