require 'rails_helper'

RSpec.describe ProductOrder, type: :model do

  context 'associations for Product Order Model' do

    it 'check belongs to associations' do
      should belong_to(:product)
      should belong_to(:order)
    end
  end

  context 'validation for Product Order Model' do
    it 'checks presence of attribute' do
      should validate_presence_of :order_id
      should validate_presence_of :product_id
      should validate_presence_of :quantity
    end

    it 'check numericality of attributes' do
      should validate_numericality_of(:order_id)
      should validate_numericality_of(:product_id)
      should validate_numericality_of(:quantity)
      # greater_than_or_equal_to: 0
    end

  end

end
