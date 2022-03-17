class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :city, :block, :building, :phone_number, :token

    validates :token, presence: true
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 
    validates :post_code, presence: true
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :city, presence: true
    validates :block, presence: true
    validates :phone_number, presence: true
    validates :phone_number, format:{with: /\A[0-9]+\z/, message: "is invalid. Input only number"}
    validates :phone_number, format:{with: /\A\d{10,11}\z/, message: "is too short"}
    validates :user_id, presence: true
    validates :item_id, presence: true

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
  end

end
