class AddCategoryIdToExpenses < ActiveRecord::Migration[7.1]
  def change
    add_reference :expenses, :category, foreign_key: true
  end
end
