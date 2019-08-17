FactoryBot.define do
  factory :message_thread do
    user_id { FactoryBot.create(:user).id }
  end
end
