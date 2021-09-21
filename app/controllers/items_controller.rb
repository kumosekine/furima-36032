class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(create_params)
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
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(create_params)
      redirect_to item_path(@item.id)
     else
      render :edit
    end
  end

  private

  def create_params
    params.require(:item).permit(:image, :product_name, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def redirect_root
    redirect_to root_path unless user_signed_in?
  end

  def move_to_index
    @item = Item.find(params[:id])
    unless @item.user == current_user
      redirect_to action: :index
    end
  end
end
