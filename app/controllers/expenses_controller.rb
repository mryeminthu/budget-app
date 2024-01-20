class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = @category.expenses.order(created_at: :desc)
  end

  def new
    @category = current_user.categories.find_by(id: params[:category_id])

    unless @category
      redirect_to root_path, alert: 'Category not found.'
      return
    end

    @expense = @category.expenses.build
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to category_path(@expense.category), notice: 'Successfully created.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :category_id)
  end
end
