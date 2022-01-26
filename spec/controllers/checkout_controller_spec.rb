require "rails_helper"

RSpec.describe CheckoutController, type: :controller do

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'Apply Coupon' do
    it 'expect to apply a coupon' do
      code = PromoCode.create(promo_code: 'DEVS1NC', discount: 0.4, valid_till: Time.now)
      post :apply_coupon, params: { coupon: code.promo_code}
      expect(flash[:notice]).to eq('Coupon applied, Select Payment Method')
    end
    it 'expect to not to apply a coupon' do
      code = PromoCode.create(promo_code: 'DE', discount: 0.4, valid_till: Time.now)
      post :apply_coupon, params: { coupon: code.promo_code}
      expect(flash[:notice]).to eq('Coupon not found')
    end
  end

  describe 'POST create' do
    it 'expect to Payment Successful Flash message' do
      user = User.find_by(id: 1)
      sign_in user

      order = Order.create(user_id: user.id)
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      product_order = ProductOrder.create(order_id: order.id, product_id: prod.id, quantity: 5 )
      #post :create, params: {id: prod.id}
      #expect(flash[:notice]).to eq('Payment Successful')
    end
  end

end
