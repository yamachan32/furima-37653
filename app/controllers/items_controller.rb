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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    redirect_to root_path unless user_signed_in? && current_user.id == @item.user_id
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to action: :show
    else
      @item = item
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :product, :explanation, :category_id, :sales_state_id, :postage_id, :prefecture_id,
                                 :post_period_id, :price).merge(user_id: current_user.id)
  end
end
