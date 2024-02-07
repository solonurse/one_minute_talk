FactoryBot.define do
  factory :explanation do
    element { "element" }
    basis { "basis" }

    association :memo
  end
end
