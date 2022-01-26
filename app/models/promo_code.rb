# frozen_string_literal: true

class PromoCode < ApplicationRecord
  validates :valid_till , presence: true
  validates :discount,presence: true, inclusion: { in: 0...1, message: 'invalid discount value, must be in between 0 and 1' },
                       numericality: true
  validates :promo_code, presence: true, length: { in: 4..10 },
                         format: { with: /\A(?=.*[A-Z])([A-Z0-9]{4,10})\z/, message: 'please enter keywords in correct format' }
  scope :available_promo_coupons, -> { where('valid_til >= ?', Time.zone.today) }
end
