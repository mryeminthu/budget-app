require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { described_class.new(name: 'Ye Min', email: 'yemin@gmail.com', password: 'StrongPassword') }

    it 'valid attributes' do
      expect(subject).to be_valid
    end

    it 'requires name to be present' do
      subject.name = ''
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'requires email to be present' do
      subject.email = ''
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it 'requires email to be unique' do
      subject.save
      duplicate_user = described_class.new(name: 'Duplicate', email: 'yemin@gmail.com', password: 'StrongPassword')
      expect(duplicate_user).to_not be_valid
      expect(duplicate_user.errors[:email]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'has many categories' do
      association = described_class.reflect_on_association(:categories)
      expect(association.macro).to eq :has_many
    end

    it 'has many expenses with foreign key author_id' do
      association = described_class.reflect_on_association(:expenses)
      expect(association.macro).to eq :has_many
      expect(association.options[:foreign_key]).to eq 'author_id'
    end
  end

  describe 'Devise modules' do
    it 'includes database_authenticatable module' do
      expect(described_class.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable module' do
      expect(described_class.devise_modules).to include(:registerable)
    end

    it 'includes recoverable module' do
      expect(described_class.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable module' do
      expect(described_class.devise_modules).to include(:rememberable)
    end

    it 'includes validatable module' do
      expect(described_class.devise_modules).to include(:validatable)
    end
  end
end
