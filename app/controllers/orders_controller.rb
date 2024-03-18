class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @products = Product.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      flash[:success] = "Order created successfully!"
      redirect_to products_path
    else
      @products = Product.all
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :quantity)
  end
end
