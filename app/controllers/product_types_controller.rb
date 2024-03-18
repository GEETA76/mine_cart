class ProductTypesController < ApplicationController
  before_action :set_product_type, only: [:show, :edit, :update, :destroy]

  def index
    @product_types = ProductType.all
  end

  def new
    @product_type = ProductType.new
  end

  def create
    @product_type = ProductType.new(product_type_params)

    if @product_type.save
      flash[:success] = "Product type created successfully!"
      redirect_to product_types_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product_type.update(product_type_params)
      flash[:success] = "Product type updated successfully!"
      redirect_to product_types_path
    else
      render :edit
    end
  end

  def destroy
    @product_type.destroy
    flash[:success] = "Product type deleted successfully!"
    redirect_to product_types_path
  end

  private

  def set_product_type
    @product_type = ProductType.find(params[:id])
  end

  def product_type_params
    params.require(:product_type).permit(:name)
  end
end
