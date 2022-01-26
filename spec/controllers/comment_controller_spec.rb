require "rails_helper"

RSpec.describe CommentsController, type: :controller do

  describe 'before actions' do
    it 'is expected to define before action' do
      is_expected.to use_before_action(:set_product_id)
      is_expected.to use_before_action(:set_comment_id)
      is_expected.to use_before_action(:authorization_of_comment)
    end
  end

  describe 'GET new' do
    it 'expect to render new template' do
      get :new
      is_expected.to render_template(:new)
    end
  end

  describe 'PUT update' do
    it 'expect to redirect to product path' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      comment = Comment.create(product_id: prod.id, user_id: user.id, content: 'testing comment')
      post :update, params: {id: comment.id, comment: { content: 'my testing content', user_id: user.id, product_id: prod.id }, user_id: user.id }
      expect(response).to redirect_to product_path(comment.product_id)
    end

    it 'expect to render edit' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      comment = Comment.create(product_id: prod.id, user_id: user.id, content: 'testing comment')
      post :update, params: {id: comment.id, comment: { content: '', user_id: user.id, product_id: prod.id }, user_id: user.id }
      is_expected.to render_template(:edit)
    end
  end

  describe 'Delete destroy' do
    it 'expected to Comment Delete' do
      user = User.find_by(id: 1)
      sign_in user
      prod = Product.create(name: 'test', description: 'testing', quantity: 50, price: 200, user_id: user.id)
      comment = Comment.create(product_id: prod.id, user_id: user.id, content: 'testing comment')
      delete :destroy, params: {id: comment.id, comment: { content: 'testing comment', user_id: user.id, product_id: prod.id }, user_id: user.id }
      expect(response).to redirect_to product_path(comment.product_id)
    end
  end

end
