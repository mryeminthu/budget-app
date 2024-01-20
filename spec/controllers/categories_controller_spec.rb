require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create!(name: 'Test User', email: 'yemin@example.com', password: 'StrongPassword') }
  let(:category) do
    user.categories.create(name: 'Test Category',
                           icon: fixture_file_upload(
                             Rails.root.join('spec', 'fixtures', 'icon.png'), 'image/png'
                           ))
  end

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST #create' do
    context 'with invalid attributes' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: { name: '', icon: nil } }
        end.to_not change(Category, :count)
        expect(response).to render_template(:new)
      end
    end
  end
end
