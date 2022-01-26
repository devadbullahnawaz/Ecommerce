# frozen_string_literal: true

class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  scope :name_similar, lambda { |name|
                         quoted_name = ActiveRecord::Base.connection.quote_string(name)
                         where('name % :name', name: name)
                           .order(Arel.sql("similarity(name, '#{quoted_name}') DESC"))
                       }
end
