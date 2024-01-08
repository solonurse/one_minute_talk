class Explanation < ApplicationRecord
  belongs_to :memo

  validates :element, presence: true
  validates :basis, presence: true
end
