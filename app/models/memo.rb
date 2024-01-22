class Memo < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :explanations, dependent: :destroy
  has_one :example, dependent: :destroy

  validates :title, presence: true
end
