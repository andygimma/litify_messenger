RSpec.describe MessageThread, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:emails)}
    it { should have_many(:message_thread_users)}
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
  end
end
