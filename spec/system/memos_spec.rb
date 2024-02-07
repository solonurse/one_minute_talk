require 'rails_helper'

RSpec.describe "Memos", type: :system do
  before do
    driven_by(:rack_test)
  end

  # pending "add some scenarios (or delete) #{__FILE__}"

  describe "メモ一覧" do
    describe "ピラミッドストラクチャーの変更" do
      it '主張、要素、根拠がある場合、編集を保存できる' do
      end

      it "主張がない場合は編集を保存に失敗する" do
      end

      it "要素がない場合は編集を保存に失敗する" do
      end

      it "根拠がない場合は編集を保存に失敗する" do
      end
    end

    describe "例文の変更" do
      it "300文字以内の場合は編集を保存できる" do
      end

      it "300文字を超えた場合は編集を保存に失敗する" do
      end
    end

    describe 'ブックマーク' do
      it "ブックマークボタンを押すとメモがブックマーク済みになる" do
      end

      it "ブックマーク済みボタンを押すとブックマークが解除される" do
      end
    end
  end

  describe "メモの新規作成" do
    it "メモの新規作成が成功すると例文が作成される" do
    end

    it "主張がない場合は新規作成に失敗する" do
    end

    it "要素がない場合は新規作成に失敗する" do
    end

    it "根拠がない場合は新規作成に失敗する" do
    end
  end

  describe "メモの編集" do
    it "メモの編集が成功すると例文が作成される" do
    end

    it "主張がない場合は編集に失敗する" do
    end

    it "要素がない場合は編集に失敗する" do
    end

    it "根拠がない場合は編集に失敗する" do
    end
  end
end
