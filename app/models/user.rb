# frozen_string_literal: true

class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
