class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_day

  validates :image, presence: true  
  validates :product_name, presence: true, length: { maximum:40 }
  validates :description, presence: true, length: { maximum:1000 }

  with_options numericality: { other_than: 1 , message: "can't be blank"} do
  validates :category_id
  validates :status_id
  validates :delivery_fee_id
  validates :prefecture_id
  validates :delivery_day_id
  end

  validates :price, numericality: { only_integer: true, greater_than:300, less_than:9999999 }
  
  has_one_attached :image
  belongs_to :user
  
end
