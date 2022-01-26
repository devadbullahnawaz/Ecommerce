class DbValidations < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :products, :users
    add_foreign_key :orders, :users
    add_foreign_key :comments, :products
    add_foreign_key :comments, :users
    add_foreign_key :product_orders, :orders
    add_foreign_key :product_orders, :products


    change_column_null :products, :name, false
    change_column_null :products, :quantity, false
    change_column_null :products, :price, false
    change_column_null :products, :user_id, false

    change_column_null :comments, :product_id, false
    change_column_null :comments, :user_id, false
    change_column_null :comments, :content, false

    change_column_null :orders, :user_id, false

    change_column_null :product_orders, :order_id, false
    change_column_null :product_orders, :product_id, false
    change_column_null :product_orders, :quantity, false

    change_column_null :promo_codes, :promo_code, false
    change_column_null :promo_codes, :valid_till, false


  end
end
