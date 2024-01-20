require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'associations' do
    it 'belongs to a user with foreign key author_id' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:foreign_key]).to eq 'author_id'
    end

    it 'belongs to a category' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    subject do
      described_class.new(name: 'Groceries', amount: 50.0,
                          user: User.create(name: 'Ye Min',
                                            email: 'yemin@example.com', password: 'StrongPassword'),
                          category: Category.create(name: 'Food'))
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'requires name to be present' do
      subject.name = ''
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'requires amount to be present' do
      subject.amount = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:amount]).to include("can't be blank")
    end

    it 'requires amount to be greater than 0' do
      subject.amount = 0
      expect(subject).to_not be_valid
      expect(subject.errors[:amount]).to include('must be greater than 0')
    end
  end
end
