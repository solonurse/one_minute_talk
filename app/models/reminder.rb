class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :memo

  validates :user_id, uniqueness: { scope: :memo_id }
  validates :start_at, presence: true
end
