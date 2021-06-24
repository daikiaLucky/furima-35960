class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :postal_code,         null: false, default: ""
      t.integer :prefecture_id,      null: false
      t.string :municipality,        null: false, default: ""
      t.string :house_number,        null: false, default: ""
      t.string :building_name
      t.string :phone_number,        null: false, default: ""
      t.references :purchase_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
