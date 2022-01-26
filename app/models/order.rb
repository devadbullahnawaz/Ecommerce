# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :user_id, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
