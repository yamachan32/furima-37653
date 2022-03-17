class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index

    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    if Order.exists?(item_id: params[:item_id]) || @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def create
    @payment = Item.find(params[:item_id]).price
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      settlement
      @order_address.save
      redirect_to root_path

    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end


  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :block, :building,
       :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:card_token])
  end

  def settlement
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @payment,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end
