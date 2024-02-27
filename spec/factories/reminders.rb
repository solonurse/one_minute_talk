FactoryBot.define do
  factory :reminder do
    reminder { false }
    start_at { "2024-02-27 10:03:12" }
    user { nil }
    memo { nil }
  end
end
