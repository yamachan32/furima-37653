class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :select_item, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :product, :explanation, :category_id, :sales_state_id, :postage_id, :prefecture_id,
                                 :post_period_id, :price).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end
end
