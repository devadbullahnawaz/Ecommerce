# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorization_of_product, only: %i[edit update destroy]
  before_action :initialize_session
  before_action :comment_initialize, only: %i[show]
  before_action :validate_session

  after_action :increment_session_count, only: %i[add_to_cart]

  def index
    @products = if params[:search].nil? || params[:search] == ''
                  Product.all.page(params[:page]).per(6)
                else
                  Product.name_similar(params[:search]).page(params[:page]).per(3)
                end
  end

  def show
    @comments = @product.comments
  end

  def new
    if user_signed_in?
      @product = current_user.products.new
    else
      redirect_to root_path, notice: 'You have to login to add new products'
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: 'Product created'
    else
      render :new
    end
  end

  def update
    if @product.user_id.eql?(current_user.id)
      if @product.update(product_params)
        redirect_to root_path, notice: 'Product Updated'
      else
        render :edit
      end
    else
      redirect_to root_path, notice: 'You are not autherized to update this product'
    end
  end

  def destroy
    if @product.user_id.eql?(current_user.id)
      @product.destroy
      redirect_to root_path, notice: 'Product Deleted'
    else
      redirect_to root_path, notice: 'You are not autherized to delete this product'
    end
  end

  def add_to_cart
    quantity = params[:quantity].to_i
    id = params[:id].to_i
    validate_cart(id)
    if quantity <= Product.find_by(id: params[:id].to_i)[:quantity] && quantity.positive?
      insert_into_cart(id, quantity)
    else
      redirect_to product_path(id), notice: 'Cannot be added to your cart'
    end
  end

  def remove_from_cart
    session[:cart].delete_if { |hash| hash['product_id'].eql?(params[:id].to_i) }
    session[:count] = session[:count].pred
    redirect_to cart_index_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :user_id, images: [])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    return unless @product.nil?

    redirect_to root_path, notice: 'Product not found'
  end

  def insert_into_cart(id, quantity)
    session[:cart] << { product_id: id, quantity: quantity }
    redirect_to root_path, notice: 'Product added to the cart'
  end

  def initialize_session
    session[:count] ||= 0
    session[:cart] ||= []
  end

  def increment_session_count
    session[:count] = session[:count] + 1
  end

  def validate_session
    return unless user_signed_in?

    id = current_user.id
    session[:cart].delete_if { |hash| Product.find_by(id: hash['product_id']).user_id == id }
  end

  def validate_cart(id)
    session[:cart].delete_if { |hash| hash['product_id'] == id }
  end

  def comment_initialize
    @new_comment = @product.comments.new
  end

  def authorization_of_product
    authorize @product
  end

end
