require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many expenses' do
      association = described_class.reflect_on_association(:expenses)
      expect(association.macro).to eq :has_many
    end

    it 'has one attached icon' do
      expect(described_class.new).to respond_to(:icon)
    end
  end

  describe 'validations' do
    subject { described_class.new(name: 'Groceries') }

    it 'requires name to be present' do
      subject.name = ''
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'requires icon to be present' do
      expect(subject).to_not be_valid
      expect(subject.errors[:icon]).to include("can't be blank")
    end
  end
end
