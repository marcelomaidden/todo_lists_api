FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 1) }
    status { :completed }
    association :user
  end
end
