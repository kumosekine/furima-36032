require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '商品購入情報の保存' do
   before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id: @user.id, item_id: @item.id)
    sleep 0.1
   end

   context '内容に問題がない場合' do
    it 'すべての値が正しく入力されていば購入できること' do
      expect(@order).to be_valid
    end
    it 'building_nameは空でも購入できる' do
      @order.building_name = ''
      expect(@order).to be_valid
    end
   end

   context '内容に問題がある場合' do
    it "tokenが空では購入できない" do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
    it 'post_codeが空だと購入できない' do
      @order.post_code = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Post code can't be blank")
    end
    it 'post_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
      @order.post_code = '1234567'
      @order.valid?
      expect(@order.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end
    it 'prefecture_idが空では購入できない' do
      @order.prefecture_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'cityが空では購入できない'do
      @order.city = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end
    it 'addressが空では購入できない' do
      @order.address = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Address can't be blank")
    end
    it 'telが空では購入できない' do
      @order.tel = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Tel can't be blank")
    end
    it 'telが半角数字以外では購入できない' do
      @order.tel = '０１２３４'
      @order.valid?
      expect(@order.errors.full_messages).to include("Tel is invalid. Please input half-width characters")
    end
    it '電話番号が9桁以下では購入できない' do
      @order.tel = '123456789'
      @order.valid?
      expect(@order.errors.full_messages).to include("Tel is too short (minimum is 10 characters)")

    end
    it '電話番号が12桁以上では購入できない' do
      @order.tel = '123456789012'
      @order.valid?
      expect(@order.errors.full_messages).to include("Tel is too long (maximum is 11 characters)")
    end
    it 'userが紐付いていなければ購入できない' do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end
     it 'itemが紐付いていなければ購入できない' do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
     end
   end
  end
end
