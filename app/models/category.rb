class Category < ApplicationRecord
  before_destroy :delete_associated_expenses
  belongs_to :user
  has_many :expenses
  has_one_attached :icon

  validates :name, presence: true
  validates :icon, presence: true

  private

  def delete_associated_expenses
    expenses.destroy_all
  end
end
