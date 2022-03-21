require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep(0.5)
  end

  describe '商品購入' do
    context '商品購入できるとき' do
      it '全ての情報が正しく入力されると購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物名の情報が空欄でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'tokenが空白(カード認証ができない)場合は購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("カード情報を入力してください")
      end
      it '郵便番号が空白だと購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号にハイフンがない場合は購入できない' do
        @order_address.post_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号はハイフンで区切ってください (例 123-4567)')
      end
      it '郵便番号が「3桁ハイフン4桁」でない場合は購入できない' do
        @order_address.post_code = '1234-567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号はハイフンで区切ってください (例 123-4567)')
      end
      it '郵便番号が半角数字でない場合は購入できない' do
        @order_address.post_code = '１２３−４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号はハイフンで区切ってください (例 123-4567)')
      end
      it '都道府県が空白 (prefecture_id = 1)の場合は購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it '市区町村が空白の場合は購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空白の場合は購入できない' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空白だと登録できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号にハイフンが含まれている場合は登録できない' do
        @order_address.phone_number = '000-00-0000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end
      it '電話番号が10桁未満だと購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号が短かすぎます')
      end
      it '電話番号が12桁以上だと購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号が短かすぎます')
      end
      it 'user情報がない（ログイン状態でない）と登録できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item情報と関連づいていないと登録できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
