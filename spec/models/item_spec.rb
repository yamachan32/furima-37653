require 'rails_helper'

RSpec.describe Item, type: :model do
  
  
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it "全ての情報が正しく入力されると出品できる" do
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it "商品画像が添付されないと出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "商品名が空白だと出品できない" do
        @item.product = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end

      it "商品の説明が空白だと出品できない" do
        @item.explanation = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it "カテゴリーの情報が空白（初期値1のまま）だと出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it "商品の状態の情報が空白（初期値1のまま）だと出品できない" do
        @item.sales_state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales state can't be blank")
      end
      it "配送料の負担の情報が空白（初期値1のまま）だと出品できない" do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it "発送元の地域の情報が空白（初期値1のまま）だと出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "発送までの日数の情報が空白（初期値1のまま）だと出品できない" do
        @item.post_period_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Post period can't be blank")
      end
      it "価格の情報がが空白だと出品できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格の情報が、¥300未満だと出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price  is out of setting range")
      end
      it "価格の情報が、¥9999999を超えると出品できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price  is out of setting range")
      end

      it "価格は半角数値でないと（全角数字）だと出品できない" do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price  is out of setting range")
      end
      it "user情報が関連づいていないと出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

    end 

  end
end
