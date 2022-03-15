class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @item = Item.order(id: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :product, :explanation, :category_id, :sales_state_id, :postage_id, :prefecture_id,
                                 :post_period_id, :price).merge(user_id: current_user.id)
  end
end
