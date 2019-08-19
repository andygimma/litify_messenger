FactoryBot.define do
  factory :message_thread_user do
    user_id { FactoryBot.create(:user).id }
    message_thread_id { FactoryBot.create(:message_thread).id }
    email_id { FactoryBot.create(:email).id }
    message_type { 'email' }
    message_id { FactoryBot.create(:email).id }
  end
end
