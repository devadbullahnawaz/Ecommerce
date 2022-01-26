class CreatePromoCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :promo_codes do |t|
      t.string :promo_code
      t.float :discount
      t.date :valid_till

      t.timestamps
    end
  end
end
