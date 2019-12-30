require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.build(:post, user_id: Faker::Number.number(2)) }

  describe '#ActiveRecord associations' do
    it { should belong_to(:user) }
    it { expect(post).to have_many(:comments) }
  end

  describe '#title' do
    it { expect(post).to validate_presence_of(:title) }
  end

  describe '#user_id' do
    it { expect(post).to validate_presence_of(:user_id) }
  end

  describe '#image' do
    it { expect(post).to validate_presence_of(:image) }
  end

  describe '#title' do
    it { expect(post).to have_db_column(:title).of_type(:string) }
  end

  describe '#user_id' do
    it { expect(post).to have_db_column(:user_id).of_type(:integer) }
  end

  describe '#image' do
    it { expect(post).to have_db_column(:image).of_type(:string) }
  end

  describe '#body' do
    it { expect(post).to have_db_column(:body).of_type(:text) }
  end
end
