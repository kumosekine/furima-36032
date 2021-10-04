class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_root

  def index
    @item = Item.find(params[:item_id])
    if @item.purchase_record.present? 
      redirect_to root_path
    else
    @order = Order.new
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new(shipping_addresses_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

   def shipping_addresses_params
    params.require(:order).permit(:post_code, :prefecture_id, :city, :address, :building_name, :tel).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
   end

   def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item[:price],
      card: shipping_addresses_params[:token],
      currency:'jpy'
    )
   end

   def redirect_root
    @item = Item.find(params[:item_id])
    if @item.user == current_user
    redirect_to root_path
    end
   end
end
