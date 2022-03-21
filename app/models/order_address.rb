class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンで区切ってください (例 123-4567)' }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'は半角数字のみで入力してください' },
                             length: { minimum: 10, maximum: 11, message: 'が短かすぎます' }
    validates :user_id
    validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block, building: building,
                   phone_number: phone_number, order_id: order.id)
  end
end
