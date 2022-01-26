# frozen_string_literal: true

class CartsController < ApplicationController

  before_action :validate_session
  before_action :user_login_check, only: %i[set_orders]

  def set_orders
    @order = current_user.orders.create
    authorize @order
    update_items
    session[:cart].clear
    redirect_to checkout_index_path, notice: 'Order Placed, Now pay via stripe to proceed'
  end

  private

  def validate_session
    return unless user_signed_in?

    user_products = current_user.products.ids
    session[:cart].delete_if { |hash| user_products.include?(hash['product_id']) }
  end

  def update_items
    session[:cart].each do |cart_item|
      @product = Product.find_by(id: cart_item['product_id'])
      update_quantity(cart_item['quantity'])
      @order.product_orders.create(product_id: cart_item['product_id'], quantity: cart_item['quantity'])
    end
  rescue StandardError
    redirect_to carts_path, error: 'Could not update quantity'
  end

  def update_quantity(qty)
    @product.decrement(:quantity, qty)
    @product.save
  end

  def user_login_check
    redirect_to new_user_session_path, notice: 'Login / Signup to checkout' unless user_signed_in?
  end

end
