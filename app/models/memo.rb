class Memo < ApplicationRecord
  has_many :explanations, dependent: :destroy
  has_many :examples, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20}
end
