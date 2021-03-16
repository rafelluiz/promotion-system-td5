class AddTokenToPromotion < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :token, :string
    add_index :promotions, :token, unique: true
  end
end
