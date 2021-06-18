class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_to_ship
  belongs_to :user
  has_one_attached :image
  #  has_one :purchase_record

  with_options presence: true do
    validates :title
    validates :description
    validates :category_id
    validates :status_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
