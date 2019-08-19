RSpec.describe Email, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:message_thread)}
    it { should have_many(:message_thread_user)}
  end

  describe 'validations' do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:body) }
  end
end