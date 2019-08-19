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

  describe 'my_dashboard_list scope' do
    it 'returns appropriate MessageThreadUser objects, in the correct order' do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)

      mtu_1 = FactoryBot.create(:message_thread_user, user_id: user_1.id)
      mtu_2 = FactoryBot.create(:message_thread_user, user_id: user_1.id)
      mtu_3 = FactoryBot.create(:message_thread_user, user_id: user_2.id)
      
      expect(MessageThreadUser.my_dashboard_list(user_1)).to eq([mtu_2, mtu_1])
    end
  end
end