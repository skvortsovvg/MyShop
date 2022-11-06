FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    association :author, factory: :user
  end
  trait :invalid_question do
    title { "" }
    body { "" }
  end
end
