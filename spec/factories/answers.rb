FactoryBot.define do
  factory :answer do
    body { "MyText" }
    question
    association :author, factory: :user
  end
end
