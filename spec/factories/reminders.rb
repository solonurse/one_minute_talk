FactoryBot.define do
  factory :reminder do
    reminder { true }

    after(:create) do |reminder|
      create(:memo, :with_explanation_and_example, reminder:)
    end

    transient do
      one_day { 24.hours }
    end

    trait :later_day do
      start_time { Time.current + one_day }

      association :user
      association :memo
    end

    trait :later_day_reminder_false do
      start_time { Time.current + one_day }
      reminder { false }

      association :user
      association :memo
    end
  end
end
