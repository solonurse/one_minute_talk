class Example < ApplicationRecord
  belongs_to :memo

  validates :sentence, length: { maximum: 300 }
end
