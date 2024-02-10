require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"

  describe 'ユーザー新規登録' do
    before do
      visit new_user_path
    end

    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        fill_in 'ユーザー名', with: 'john'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content "ユーザー登録が完了しました"
        expect(current_path).to eq login_path
      end
    end

    context 'ユーザー名が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content "ユーザー登録に失敗しました"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(current_path).to eq users_path
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        fill_in 'ユーザー名', with: 'john'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content "ユーザー登録に失敗しました"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(current_path).to eq users_path
      end
    end

    context '登録済みのメールアドレスを入力する' do
      it 'ユーザーの新規作成が失敗する' do
        exist_user = create(:user)
        fill_in 'メールアドレス', with: exist_user.email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content "メールアドレスはすでに存在します"
        expect(current_path).to eq users_path
        expect(page).to have_field 'メールアドレス', with: exist_user.email
      end
    end

    context 'パスワードが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        fill_in 'ユーザー名', with: 'john'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_button '登録'
        expect(page).to have_content "ユーザー登録に失敗しました"
        expect(page).to have_content "パスワードは8文字以上で入力してください"
        expect(page).to have_content "パスワード確認を入力してください"
        expect(current_path).to eq users_path
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }

    before do
      visit login_path
    end

    context 'フォームの入力値が正常' do
      it 'ログインが成功する' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content "ログインしました"
      end
    end

    context 'メールアドレスが未入力' do
      it 'ログインが失敗する' do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content "ログインに失敗しました"
      end
    end

    context 'パスワードが未入力' do
      it 'ログインが失敗する' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
        expect(page).to have_content "ログインに失敗しました"
      end
    end
  end

  describe 'ログアウト' do
    let(:user) { create(:user) }
    it 'ログアウトされる' do
      login_as(user)
      click_link 'ログアウト'
      expect(page).to have_content "ログアウトしました"
    end
  end
end
