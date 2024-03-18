class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  # This method is used to show all products
  def index
    @products = Product.all
    @vendors = Vendor.all
    @product_types = ProductType.all

    @products = @products.where(vendor_id: params[:vendor_id]) if params[:vendor_id].present?
    @products = @products.where(product_type_id: params[:product_type_id]) if params[:product_type_id].present?

    puts "Found #{@products.count} products"
    render :index
  end

  # This is the product new method
  def new
    @product = Product.new
    @vendors = Vendor.all
    @product_types = ProductType.all
  end

  # This is the product create method
  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      flash[:success] = "Product created successfully!"
      redirect_to products_path
    else
      @vendors = Vendor.all
      @product_types = ProductType.all
      render :new
    end
  end

  def show
  end

  def edit
  end

  # This method update the product
  def update
    if @product.update(product_params)
      flash[:success] = "Product updated successfully!"
      redirect_to products_path
    else
      render :edit
    end
  end

  # This method delete the product
  def destroy
    @product.destroy
    flash[:success] = "Product deleted successfully!"
    redirect_to products_path, notice: "Product deleted successfully."
  end

  def report
    @vendor_buyers = report_by_vendor
    @product_type_buyers = report_by_product_type
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :vendor_id, :product_type_id)
  end

  # Implement report generation logic here
  def report_by_vendor
    orders = Order.all

    # Group orders by vendor and calculate total quantity purchased per vendor
    vendor_buyers = orders.group_by(&:vendor).map do |vendor, orders|
      { vendor: vendor.try(:name), total_quantity: orders.sum(&:quantity) }
    end

    vendor_buyers
  end

  def report_by_product_type
    orders = Order.all

    # Group orders by product type and calculate total quantity purchased per type
    product_type_buyers = orders.group_by(&:product_type).map do |product_type, orders|
      { product_type: product_type.try(:name), total_quantity: orders.sum(&:quantity) }
    end

    product_type_buyers
  end
end
