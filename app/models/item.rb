class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :category
    belongs_to_active_hash :sales_state
    belongs_to_active_hash :postage
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :post_period

  validates :image, presence: true
  validates :product, presence: true
  validates :explanation, presence: true

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :sales_state_id
    validates :postage_id
    validates :prefecture_id
    validates :post_period_id
  end

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 ,message: " is out of setting range" }

end
