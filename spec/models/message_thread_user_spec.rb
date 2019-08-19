RSpec.describe MessageThreadUser, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:message_thread)}
    it { should belong_to(:email)}
  end

  describe 'validations' do
    it { should validate_presence_of(:email_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:message_thread_id) }
  end
end