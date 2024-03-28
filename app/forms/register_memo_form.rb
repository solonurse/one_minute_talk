class RegisterMemoForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_reader :chatgpt_error_message

  attribute :title
  3.times do |i|
    attribute :"element_#{i}"
    attribute :"basis_#{i}"
  end
  attribute :user_id
  attribute :memo_id

  validates :title, :user_id, presence: true

  def save
    return false if invalid?

    begin
      ActiveRecord::Base.transaction do
        save_transaction
        create_example
      end
    rescue Faraday::BadRequestError, StandardError => e
      @chatgpt_error_message = e.message
      false
    end
  end

  def update
    return false if invalid?

    @memo_title = Memo.find_by(id: memo_id, user_id:)

    begin
      ActiveRecord::Base.transaction do
        update_transaction
        update_example
      end
    rescue Faraday::BadRequestError, StandardError => e
      @chatgpt_error_message = e.message
      false
    end
  end

  private

  def save_transaction
    @memo_title = Memo.create!(title:, user_id:)

    @explanations = {}
    create_elements_basis
    raise ActiveRecord::Rollback if @explanations.blank?
  end

  def create_elements_basis
    3.times do |i|
      element = send(:"element_#{i}")
      basis = send(:"basis_#{i}")
      if element.present? && basis.present?
        @explanations[i] = @memo_title.explanations.create!(element:, basis:)
      elsif element.blank? && basis.blank?
        next
      else
        raise ActiveRecord::Rollback
      end
    end
  end

  def update_elements_basis
    3.times do |i|
      element = send(:"element_#{i}")
      basis = send(:"basis_#{i}")

      if element.present? && basis.present?
        if @memo_title.explanations[i].present?
          @memo_title.explanations[i].update!(element:, basis:)
          @explanations[i] = @memo_title.explanations[i]
        else
          @explanations[i] = @memo_title.explanations.create!(element:, basis:)
        end
      elsif element.blank? && basis.blank?
        @memo_title.explanations[i].destroy! if @memo_title.explanations[i].present?
      else
        raise ActiveRecord::Rollback
      end
    end
  end

  def update_transaction
    @memo_title.update!(title:)
    @explanations = {}
    update_elements_basis

    raise ActiveRecord::Rollback if @explanations.blank?
  end

  def questions_for_chatgpt
    example_sententce = "Point : #{@memo_title.title}"
    @explanations.length.times do |i|
      example_sententce += "\nReason #{i} : #{@explanations[i][:element]}
                            \nSpecific example of reason #{i} : #{@explanations[i][:basis]}"
    end
    example_sententce
  end

  def create_example
    chatgpt_sententce = ChatgptService.new.chat(questions_for_chatgpt)
    @memo_title.create_example!(memo_id: @memo_title.id, sentence: chatgpt_sententce)
  end

  def update_example
    chatgpt_sententce = ChatgptService.new.chat(questions_for_chatgpt)
    @memo_title.example.update!(sentence: chatgpt_sententce)
  end
end
