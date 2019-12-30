require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { FactoryGirl.build(:user) }

  describe '#ActiveRecord associations' do
    it { expect(user).to have_many(:posts) }
    it { expect(user).to have_many(:comments).through(:posts) }
  end

  describe '#name' do
    it { expect(user).to validate_presence_of(:name) }
  end

  describe '#name' do
    it { expect(user).to have_db_column(:name).of_type(:string) }
  end
end
