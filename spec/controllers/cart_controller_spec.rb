require "rails_helper"

RSpec.describe CartsController, type: :controller do

  describe 'before actions' do
    it 'is expected to define before action' do
      is_expected.to use_before_action(:validate_session)
      is_expected.to use_before_action(:user_login_check)
    end
  end

  describe 'Order Placed' do
    it 'expect to place an order' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      post :set_orders, params: { current_user: user }, session: { cart: [{ 'product_id' => prod.id, quantity: 5 }] }
      expect(response).to redirect_to checkout_index_path
    end
  end
end
