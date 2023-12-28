require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

    it "ユーザー名、メール、パスワードがある場合、新規登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ユーザ名がない場合にバリデーションが機能して新規登録できない" do
      user_without_name = build(:user, name: "")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to include("を入力してください")
    end

    it "メールがない場合にバリデーションが機能して新規登録できない" do
      user_without_email = build(:user, email: "")
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスの場合バリデーションが機能して新規登録できない" do
      user1 = FactoryBot.create(:user, email: 'user@example.com')
      user2 = FactoryBot.build(:user, email: 'user@example.com')
      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it "パスワードがない場合にバリデーションが機能して新規登録できない" do
      user_without_password = build(:user, password: "")
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to include("は8文字以上で入力してください")
    end
end
