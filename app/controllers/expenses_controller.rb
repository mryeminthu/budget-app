class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[index new create]

  def index
    @expenses = @category.expenses.order(created_at: :desc)
  end

  def new
    @expense = @category.expenses.build
  end

  def create
    @expense = @category.expenses.build(expense_params.merge(user: current_user))

    if @expense.save
      redirect_to category_path(@category), notice: 'Successfully created.'
    else
      render :new
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
