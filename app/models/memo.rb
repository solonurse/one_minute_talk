class Memo < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maxmum: 30}
end
