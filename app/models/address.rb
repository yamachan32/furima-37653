class Address < ApplicationRecord


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :order

  with_options presence: true do
  validates :post_code
  validates :city
  validates :block
  validates :phone_number
  end
  
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 

end
