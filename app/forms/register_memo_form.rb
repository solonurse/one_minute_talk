class RegisterMemoForm

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :title
  attribute :element_0
  attribute :element_1
  attribute :element_2
  attribute :basis_0
  attribute :basis_1
  attribute :basis_2
  attribute :user_id
  attribute :memo_id

  with_options presence: true do
    validates :title
    validates :user_id
    validates :element_0
    validates :element_1
    validates :element_2
    validates :basis_0
    validates :basis_1
    validates :basis_2
  end

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      memo_title = Memo.create!(title: title, user_id: user_id)
      memo_title.explanations.create!(element: element_0, basis: basis_0) if element_0.present? && basis_0.present?
      memo_title.explanations.create!(element: element_1, basis: basis_1) if element_1.present? && basis_1.present?
      memo_title.explanations.create!(element: element_2, basis: basis_2) if element_2.present? && basis_2.present?
    end
    true
  end

  def update
    return false if invalid?
    memo_explanations = Memo.includes(:explanations).find_by(id: memo_id, user_id: user_id)

    ActiveRecord::Base.transaction do
      memo_explanations.update!(title: title)
      memo_explanations.explanations[0].update!(element: element_0, basis: basis_0) if element_0.present? && basis_0.present?
      memo_explanations.explanations[1].update!(element: element_1, basis: basis_1) if element_1.present? && basis_1.present?
      memo_explanations.explanations[2].update!(element: element_2, basis: basis_2) if element_2.present? && basis_2.present?
    end
    true
  end
end