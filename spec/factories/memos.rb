FactoryBot.define do
  factory :memo do
    title { "title" }

    trait :with_explanation_and_example do
      after(:create) do |memo|
        create(:explanation, memo:)
        create(:example, memo:)
      end
      association :user
    end

    association :user
  end
end
