class Example < ApplicationRecord
  belongs_to :memo

  validates :sentences, length: { maximum: 300}
end
