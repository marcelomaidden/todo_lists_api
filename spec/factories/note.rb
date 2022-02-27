FactoryBot.define do
  factory :note do
    description { Faker::Lorem.sentence(word_count: 3) }
    association :task
  end
end