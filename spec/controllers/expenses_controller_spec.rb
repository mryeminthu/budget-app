require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) do
    User.find_or_create_by(email: 'test@example.com') do |u|
      u.password = 'password'
      u.name = 'Test User'
    end
  end
  let(:valid_icon) do
    fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'arrow-left.svg'), 'image/svg+xml')
  end
  let(:category) { user.categories.create!(name: 'Test Category', icon: valid_icon) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { category_id: category.id }
      expect(response).to be_successful
    end

    it 'assigns a new expense' do
      get :new, params: { category_id: category.id }
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end

  describe 'POST #create' do
    let(:expense_params) { { name: 'Sample Expense', amount: 100 } }

    it 'renders the new template when expense is not saved' do
      post :create, params: { expense: { name: nil, amount: 100 }, category_id: category.id }
      expect(response).to render_template(:new)
    end
  end
end
