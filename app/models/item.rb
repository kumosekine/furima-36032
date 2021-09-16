class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_day

  with_options presence: true do
  validates :image, 
  validates :product_name, length: { maximum:40 }
  validates :description, length: { maximum:1000 }
  end

  with_options numericaleity: { other_than: 1 , message: "can't be blank"} do
  validates :category
  validates :status
  validates :delivery_fee
  validates :prefecture
  validates :delivery_day
  end

  validates :price, numericality: { only_integer: true, greater_than:0, less_than:9999999 }
  
  has_one_attached :image

end
