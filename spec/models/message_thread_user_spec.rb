RSpec.describe MessageThreadUser, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:message_thread)}
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:message_thread_id) }
  end

  describe 'user_dashboard_list scope' do
    it 'returns appropriate MessageThreadUser objects, in the correct order' do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)

      mtu_1 = FactoryBot.create(:message_thread_user, user_id: user_1.id)
      mtu_2 = FactoryBot.create(:message_thread_user, user_id: user_1.id)
      mtu_3 = FactoryBot.create(:message_thread_user, user_id: user_2.id)
      
      expect(MessageThreadUser.user_dashboard_list(user_1, 'email')).to eq([mtu_2, mtu_1])
    end

    it 'returns appropriate MessageThreadUser objects, when objects share a MessageThread' do
      user = FactoryBot.create(:user)
      message_thread = FactoryBot.create(:message_thread)

      mtu_1 = FactoryBot.create(:message_thread_user, user_id: user.id, message_thread_id: message_thread.id)
      mtu_2 = FactoryBot.create(:message_thread_user, user_id: user.id, message_thread_id: message_thread.id)
      
      expect(MessageThreadUser.user_dashboard_list(user, 'email')).to eq([mtu_2])
    end

    it 'returns objects with the correct message_type' do
      user = FactoryBot.create(:user)
      message_thread = FactoryBot.create(:message_thread)

      mtu_1 = FactoryBot.create(:message_thread_user, user_id: user.id, message_type: 'email')
      mtu_2 = FactoryBot.create(:message_thread_user, user_id: user.id, message_type: 'chat')
      
      expect(MessageThreadUser.user_dashboard_list(user, 'email')).to eq([mtu_1])
    end
  end
end