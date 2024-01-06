class Explanation < ApplicationRecord
  belongs_to :memo

  validates :element, presence: true, length: { maximum: 20}
  validates :basis, presence: true, length: { maximum: 50}
end
