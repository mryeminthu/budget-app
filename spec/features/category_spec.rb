require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'User sees information on the root page' do
    visit root_path

    expect(page).to have_content(user.name)
    expect(page).to have_content('Total cost for all categories')
    expect(page).to have_link('Add a new category', href: new_category_path)
  end

  scenario 'User visits a category page' do
    category = create(:category, user:)
    visit category_path(category)
    expect(page).to have_content('Total cost for this category')
  end
end
