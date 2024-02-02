class RegisterMemoForm

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_reader :chatgpt_error_message

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
      @memo_title = Memo.create!(title: title, user_id: user_id)
      @explanations = {}

      (0..2).each do |i|
        element = send("element_#{i}")
        basis = send("basis_#{i}")

        if element.present? && basis.present?
          @explanations[i] = @memo_title.explanations.create!(element: element, basis: basis) 
        elsif element.blank? && basis.blank?
          next
        else
          @explanations = {}
          return false
        end
      end
      return false if @explanations.blank?

      chatgpt_sententce = ChatgptService.new.chat(questions_for_chatgpt)
      @memo_title.create_example!(memo_id: @memo_title.id, sentence: chatgpt_sententce)
    end
    true
  end

  def update
    return false if invalid?
    @memo_title = Memo.find_by(id: memo_id, user_id: user_id)

    ActiveRecord::Base.transaction do
      begin
        @memo_title.update!(title: title)
        @explanations = {}

        (0..2).each do |i|
          # 更新するデータ
          element = send("element_#{i}")
          basis = send("basis_#{i}")

          if element.present? && basis.present?
            if @memo_title.explanations[i].present?
              @memo_title.explanations[i].update!(element: element, basis: basis)
              @explanations[i] = @memo_title.explanations[i]
            else
              @explanations[i] = @memo_title.explanations.create!(element: element, basis: basis)
            end
          elsif element.blank? && basis.blank?
            @memo_title.explanations[i].destroy! if @memo_title.explanations[i].present?
          else
            @explanations = {}
            return false
          end
        end
        return false if @explanations.blank?

        chatgpt_sententce = ChatgptService.new.chat(questions_for_chatgpt)
        @memo_title.example.update!(sentence: chatgpt_sententce)
      rescue Faraday::BadRequestError => e
        @chatgpt_error_message = e.message
        return false
      rescue StandardError => e
        @chatgpt_error_message = e.message
        return false
      end
    end
    true
  end

  private

  def questions_for_chatgpt
    example_sententce = "Point : #{@memo_title.title}"
    @explanations.length.times do |i|
      example_sententce += "\nReason #{i} : #{@explanations[i][:element]}
                            \nSpecific example of reason #{i} : #{@explanations[i][:basis]}"
    end
    return example_sententce
  end
end