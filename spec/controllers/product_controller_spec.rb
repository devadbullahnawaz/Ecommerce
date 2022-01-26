require "rails_helper"

RSpec.describe ProductsController, type: :controller do

  describe 'before actions' do
    it 'is expected to define before action' do
      is_expected.to use_before_action(:set_product)
      is_expected.to use_before_action(:initialize_session)
      is_expected.to use_before_action(:authorization_of_product)
      is_expected.to use_before_action(:comment_initialize)
      is_expected.to use_before_action(:validate_session)
    end
  end

  describe 'after actions' do
    it 'is expected to define after action' do
      is_expected.to use_after_action(:increment_session_count)
    end
  end


  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    it 'expect to render new template' do
      user = User.create(email: 'qwerty@gmail.com', password: 'abdullah')
      sign_in user
      get :new, params: { user_id: user, name: 'Abd', description: 'testing desc', quantity:200, price: 200}
      is_expected.to render_template(:new)
    end

    it 'expect to redirect to root path' do
      user = User.create(email: 'qwerty@gmail.com', password: 'abdullah')
      get :new, params: { user_id: user, name: 'Abd', description: 'testing desc', quantity:200, price: 200}
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST create' do
    it 'expect to redirect to root path' do
      user = User.find_by(id: 1)
      sign_in user
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload('bag1.jpeg')
      post :create, params: { product: { user_id: user.id, name: 'Abd', description: 'testing desc', quantity: 200, price: 200, images: [file] }, user_id: user.id }
      expect(response).to redirect_to root_path
    end

    it 'expect to render new template' do
      user = User.find_by(id: 1)
      sign_in user
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload('bag1.jpeg')
      post :create, params: { product: { user_id: user.id, name: '', description: 'testing desc', quantity: 200, price: 200, images: [file] }, user_id: user.id }
      is_expected.to render_template(:new)
    end
  end

  describe 'PUT update' do
    it 'expect to redirect to root path' do
      user = User.find_by(id: 1)
      sign_in user
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload('bag1.jpeg')
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      put :update, params: { id: prod.id , product: { user_id: user.id, name: 'abc', description: 'testing desc', quantity: 200, price: 200, images: [file] }, user_id: user.id }
      expect(response).to redirect_to root_path
    end

    it 'expect to render new template' do
      user = User.find_by(id: 1)
      sign_in user
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload('bag1.jpeg')
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      put :update, params: { id: prod.id , product: { user_id: user.id, name: '', description: 'testing desc', quantity: 200, price: 200, images: [file] }, user_id: user.id }
      is_expected.to render_template(:edit)
    end
  end

  describe 'Delete' do
    it 'expect to Product Deleted Flash message' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      delete :destroy, params: { id: prod.id, user_id: user.id }
      expect(flash[:notice]).to eq('Product Deleted')
    end
  end

  describe 'Adding to Cart' do
    it 'expect to add to cart' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      post :add_to_cart, params: { id: prod.id, quantity: "5", product_id: prod.id }
      expect(flash[:notice]).to eq('Product added to the cart')
    end

    it 'expect not to add to cart' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      post :add_to_cart, params: { id: prod.id, quantity: "55", product_id: prod.id }
      expect(flash[:notice]).to eq('Cannot be added to your cart')
    end
  end

  describe 'Removing from Cart' do
    it 'expect to redirect to cart_index_path' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      post :remove_from_cart, params: { id: prod.id}, session: { cart: [{ 'product_id' => prod.id, quantity: 5 }] }
      expect(response).to redirect_to cart_index_path
    end
  end

end
