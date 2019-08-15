RSpec.describe Email, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:read) }
  end
end