# frozen_string_literal: true

class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :order_id, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :product_id, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
