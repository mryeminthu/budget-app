class Expense < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :category

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
