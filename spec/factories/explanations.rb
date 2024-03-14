FactoryBot.define do
  factory :explanation do
    sequence(:element) { |n| "element_#{n}" }
    sequence(:basis) { |n| "basis_#{n}" }

    memo
  end
end
