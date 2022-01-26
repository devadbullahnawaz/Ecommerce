# frozen_string_literal: true

require 'stripe'

class CheckoutController < ApplicationController

  def index
    @my_last_order = ProductOrder.where(order_id: current_user&.orders&.last&.id)
  end

  def apply_coupon
    code = PromoCode.find_by(promo_code: params[:coupon])
    redirect_to checkout_index_path, notice: "#{code == nil ? 'Coupon not found' : 'Coupon applied, Select Payment Method'}"
  end

  def create
    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id, payment_method_types: ['card'],
                                                  line_items: [cart_items],
                                                  mode: 'payment',
                                                  cancel_url: failure_url_with_notice,
                                                  success_url: success_url_with_notice
                                                })
    respond_to do |format|
      format.js
    end
  end

  private

  def cart_items
    debugger
    items = []
    my_order_products = ProductOrder.where(order_id: current_user.orders.last.id)

    my_order_products.each do |cart_item|
      product = Product.find_by(id: cart_item['product_id'])
      new_val = ((session[:discount_percentage] || 1) * product.price).to_i
      items << { name: product.name, amount: new_val, currency: 'usd', quantity: cart_item['quantity'] }
    end
    items
  end

  def success_url_with_notice
    flash[:notice] = 'Payment Successfull'
    root_url
  end

  def failure_url_with_notice
    flash[:notice] = 'Payment not Successfull'
    root_url
  end

end
