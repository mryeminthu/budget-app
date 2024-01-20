require 'rails_helper'

RSpec.feature 'Expense creation', type: :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  before do
    login_as(user, scope: :user)
    visit new_category_expense_path(category)
  end

  scenario 'User creates a new expense' do
    within 'form' do
      fill_in 'Name', with: 'New Expense'
      fill_in 'Amount', with: 50
      select category.name, from: 'Select a category'
      click_button 'Save'
    end

    expect(page).to have_content('Successfully created.')
    expect(page).to have_content('New Expense')
    expect(page).to have_content('$50.0')
  end

  scenario 'User sees the new expense form' do
    expect(page).to have_content('Name')
    expect(page).to have_content('Amount')
    expect(page).to have_content('Select a category')
  end
end
