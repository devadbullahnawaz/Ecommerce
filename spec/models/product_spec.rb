require 'rails_helper'

RSpec.describe Product, type: :model do

  context 'associations for Product Model' do
    it 'should check has many for images associations' do
      should have_many_attached(:images)
    end

    it 'check has many associations' do
      should have_many(:comments).dependent(:destroy)
      should have_many(:product_orders).dependent(:destroy)
      should have_many(:orders)
    end

    it 'check belongs to associations' do
      should belong_to(:user)
    end
  end

  context 'validation for Product Model' do
    it 'checks presence of attribute' do
      should validate_presence_of :name
      should validate_presence_of :description
      should validate_presence_of :quantity
      should validate_presence_of :price
    end

    it 'check length of attribute' do
      should validate_length_of(:name).is_at_most(50)
      should validate_length_of(:description).is_at_most(250)
    end

    it 'check numericality of attributes' do
      should validate_numericality_of(:quantity)
      should validate_numericality_of(:price)
      # greater_than_or_equal_to: 0
    end

  end

end
