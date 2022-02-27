FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { '123456' }
  end
end
