class Order
  include ActiveModel::Model 
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :tel, :user_id, :item_id ,:purchase_record_id, :token

  with_options presence: true do
  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :city
  validates :address
  validates :tel, format: {with: /\A[0-9]+\z/, message: "is invalid. Please input half-width characters"},length: { minimum:10 ,maximum: 11 }
  validates :token
  validates :user_id
  validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, tel: tel, purchase_record_id: purchase_record.id )
  end
end