class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show destroy]

  def index
    @categories = current_user.categories.includes(:icon_attachment)
    @expenses = Expense.where(category: @categories).order(created_at: :desc)
  end

  def show
    @category_expenses = @category.expenses.order(created_at: :desc)
    @total_amount = @category_expenses.sum(:amount)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      redirect_to root_path, notice: 'Successfully created.'
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      redirect_to root_path, notice: 'Successfully deleted.'
    else
      redirect_to root_path, alert: 'Failed to delete category.'
    end
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id]) if params[:id].present?
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
