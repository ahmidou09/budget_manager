class TransfersController < ApplicationController
  before_action :set_user, only: %i[new create]
  before_action :set_category, only: %i[new create]

  def new
    @transfer = Transfer.new
  end

  def create
    @transfer = Transfer.new(set_params)
    @transfer.user_id = current_user.id

    if (@category.transfers << @transfer) && @transfer.save
      redirect_to category_path(@category), notice: 'Transaction created successfully'
    else
      render :new, alert: 'Error creating the Transaction'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_category
    @category = @user.categories.find(params[:category_id])
  end

  def set_params
    params.require(:transfer).permit(:name, :amount)
  end
end
