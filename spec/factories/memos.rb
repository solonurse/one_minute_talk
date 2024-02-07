FactoryBot.define do
  factory :memo do
    title {"title"}

    association :user
  end
end
