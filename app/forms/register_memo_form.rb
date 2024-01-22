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
  end

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      memo_title = Memo.create!(title: title, user_id: user_id)

      (0..2).each do |i|
        element = send("element_#{i}")
        basis = send("basis_#{i}")
        memo_title.explanations.create!(element: element, basis: basis) if element.present? && basis.present?
      end

      memo_title.create_example!(memo_id: memo_title.id, sentence: '例文')
      # example_sententce = chat_gpt_service.chat("")
    end
    true
  end

  def update
    return false if invalid?
    memo_explanations = Memo.includes(:explanations, :example).find_by(id: memo_id, user_id: user_id)

    ActiveRecord::Base.transaction do
      memo_explanations.update!(title: title)

      (0..2).each do |i|
        element = send("element_#{i}")
        basis = send("basis_#{i}")
        explanation = memo_explanations.explanations[i]

        if explanation.present?
          if element.present? && basis.present?
            explanation.update!(element: element, basis: basis)
          elsif element.blank? && basis.blank?
            explanation.destroy! if explanation.present?
          else
            return false
          end
        else
          memo_explanations.explanations.create!(element: element, basis: basis) if element.present? && basis.present?
        end
      end

      memo_explanations.example.update!(sentence: '新しい例文')
      # example_sententce = chat_gpt_service.chat("")
    end
    true
  end
end