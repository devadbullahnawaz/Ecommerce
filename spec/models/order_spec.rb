require 'rails_helper'

RSpec.describe Order, type: :model do

  context 'associations for Order Model' do
    it 'check has many associations' do
      should have_many(:product_orders).dependent(:destroy)
      should have_many(:products)
    end

    it 'check belongs to associations' do
      should belong_to(:user)
    end
  end

  context 'validation for Order Model' do
    it 'checks presence of attribute' do
      should validate_presence_of :user_id
    end

    it 'check numericality of attributes' do
      should validate_numericality_of(:user_id)
      # greater_than_or_equal_to: 0
    end
  end
end
