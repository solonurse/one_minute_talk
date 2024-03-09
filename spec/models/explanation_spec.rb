require 'rails_helper'

RSpec.describe Explanation, type: :model do
  let(:explanation) { build(:explanation) }
  it "要素、根拠がある場合に登録できる" do
    expect(explanation).to be_valid
  end

  let(:explanation_without_element) { build(:explanation, element: "") }
  it "要素がない場合にバリデーションが機能して登録できない" do
    expect(explanation_without_element).to be_invalid
  end

  let(:explanation_without_basis) { build(:explanation, basis: "") }
  it "根拠がない場合にバリデーションが機能して登録できない" do
    expect(explanation_without_basis).to be_invalid
  end
end
