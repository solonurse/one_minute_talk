require 'rails_helper'

RSpec.describe Example, type: :model do

  let(:sentence) { build(:example) }
  it "300文字以内の場合に登録できる" do
    expect(sentence).to be_valid
  end

  let(:example_character_over) { build(:example, :example_character_over) }
  it "300文字を超えた場合にバリデーションが機能して登録できない" do
    expect(example_character_over).to be_invalid
  end
end
