class AddIndexToProduct < ActiveRecord::Migration[5.2]
  def change
    enable_extension :pg_trgm
    add_index :products, :name, opclass: :gin_trgm_ops, using: :gin
  end
end
