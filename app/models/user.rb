class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :memos, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_memos, through: :bookmarks, source: :memo

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # ブックマークに追加する
  def bookmark(memo)
    bookmark_memos << memo
  end

  # ブックマークを外す
  def unbookmark(memo)
    bookmark_memos.destroy(memo)
  end

  # ブックマークをしているか判定する
  def bookmark?(memo)
    bookmark_memos.include?(memo)
  end
end
