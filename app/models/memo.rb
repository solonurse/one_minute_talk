class Memo < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :explanations, dependent: :destroy
  has_one :example, dependent: :destroy
  has_one :reminder, dependent: :destroy
  has_one :reminder_user, through: :reminder, source: :user

  validates :title, presence: true
end
