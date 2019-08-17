RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:emails) }
    it { should have_many(:message_threads) }
    it { should have_many(:message_thread_users) }
    it { should have_many(:emails) }

  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end

  describe 'all_except scope' do
    it 'returns all users except the user with id passed in as a param' do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      user_3 = FactoryBot.create(:user)
      
      expect(User.all_except(user_1)).to eq([user_2, user_3])
    end
  end
end