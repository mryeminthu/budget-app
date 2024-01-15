class ChangeCategoryIdToAuthorIdInExpenses < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :expenses, :categories
    remove_index :expenses, :column => :category_id
    rename_column :expenses, :category_id, :author_id
    add_foreign_key :expenses, :users, column: :author_id
    add_index :expenses, :author_id
  end
end
