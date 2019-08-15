FactoryBot.define do
  factory :email do
    user_id { FactoryBot.create(:user).id }
    subject { Faker::Company.name  }
    body { Faker::Company.catch_phrase }
    read { Faker::Boolean.boolean }
  end
end
