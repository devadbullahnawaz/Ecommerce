require 'rails_helper'

RSpec.describe PromoCode, type: :model do

  context 'validation for Promo Code Model' do
    it 'checks presence of attribute' do
      should validate_presence_of :discount
      should validate_presence_of :valid_till
      should validate_presence_of :promo_code
    end

    it 'check length of attribute' do
      should validate_length_of(:promo_code).is_at_least(4)
      should validate_length_of(:promo_code).is_at_most(10)
    end

    it 'check numericality of attributes' do
      should validate_numericality_of(:discount)
    end
  end
end
