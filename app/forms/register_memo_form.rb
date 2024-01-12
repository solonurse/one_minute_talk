class RegisterMemoForm

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :memo_title
  attribute :element_0
  attribute :element_1
  attribute :element_2
  attribute :basis_0
  attribute :basis_1
  attribute :basis_2
  attribute :user_memo_id

  validates :user_memo_id, presence: true
  with_options presence: true do
    validates :memo_title
    validates :element_0
    validates :element_1
    validates :element_2
  end

  def save
    ActiveRecord::Base.transaction do
      memo_title = Memo.create(title: memo_title, user_id: user_memo_id)
      memo_title.explanations.create(element: element_0, basis: basis_0) if element_0.present?
      memo_title.explanations.create(element: element_1, basis: basis_1) if element_1.present?
      memo_title.explanations.create(element: element_2, basis: basis_2) if element_2.present?
    end
  # rescue ActiveRecord::RecordInvalid
  #   false
  end
end