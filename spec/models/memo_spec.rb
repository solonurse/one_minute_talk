require 'rails_helper'

RSpec.describe Memo, type: :model do
  it "タイトルがある場合、登録できる" do
    memo = build(:memo)
    expect(memo).to be_valid
  end

  it "タイトルがある場合、登録できない" do
    memo_without_title = build(:memo, title: "")
    expect(memo_without_title).to be_invalid
  end
end
