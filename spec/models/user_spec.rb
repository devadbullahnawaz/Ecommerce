require 'rails_helper'

RSpec.describe User, type: :model do

  context 'associations for User Model' do
    it 'should check has one associations' do
      should have_one_attached(:image)
    end

    it 'check has many associations' do
      should have_many(:products).dependent(:destroy)
      should have_many(:comments).dependent(:destroy)
      should have_many(:orders).dependent(:destroy)
    end
  end

end
