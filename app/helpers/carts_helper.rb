# frozen_string_literal: true

module CartsHelper
  def get_price(id, qty)
    price = Product.find_by(id: id).price
    price * qty
  end

  def get_product_name(id)
    Product.find_by(id: id).name
  end

  def cart_total
    total = 0
    session[:cart].each do |product|
      total += get_price(product['product_id'], product['quantity'])
    end
    total
  end
end
