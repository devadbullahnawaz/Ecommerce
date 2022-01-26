require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'associations for Comment Model' do
    it 'check belongs to associations' do
      should belong_to(:product)
    end
  end

  context 'validation for Comment Model' do
    it 'checks presence of attribute' do
      should validate_presence_of :content
    end

    it 'check length of attribute' do
      should validate_length_of(:content).is_at_most(250)
    end
  end
end
