require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryGirl.build(:comment) }

  describe '#ActiveRecord associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe '#body' do
    it { expect(comment).to validate_presence_of(:body) }
  end

  describe '#user_id' do
    it { expect(comment).to have_db_column(:user_id).of_type(:integer) }
  end

  describe '#body' do
    it { expect(comment).to have_db_column(:body).of_type(:text) }
  end

  describe '#post_id' do
    it { expect(comment).to have_db_column(:post_id).of_type(:integer) }
  end
end
