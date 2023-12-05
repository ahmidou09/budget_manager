class CategoriesController < ApplicationController
  before_action :set_user, only: %i[index show create]
  before_action :set_category, only: %i[show]

  def index
    load_categories_and_transfers
  end

  def show
    load_category_and_transfers
    calculate_total_amount
  end

  def new
    @category = Category.new
  end

  def create
    build_and_save_category
  end

  private

  def set_user
    @user = current_user
  end

  def set_category
    @category = @user.categories.find(params[:id])
  end

  def set_params
    params.require(:category).permit(:name, :icon)
  end

  def load_categories_and_transfers
    @categories = @user.categories.includes(:transfers)
    @transfers = @categories.flat_map { |category| category.transfers.where(user_id: current_user.id).to_a }
  end

  def load_category_and_transfers
    @transfers = @category.transfers.where(user_id: current_user.id).order(created_at: :desc)
  end

  def calculate_total_amount
    @total_amount = @transfers.sum(&:amount)
  end

  def build_and_save_category
    @category = @user.categories.build(set_params)
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully'
    else
      render :new, alert: 'Error creating the Category'
    end
  end
end
