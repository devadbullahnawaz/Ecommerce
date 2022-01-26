
# frozen_string_literal: true

module CheckoutsHelper

  def get_product_name(id)
    Product.find_by(id: id).name
  end

end
