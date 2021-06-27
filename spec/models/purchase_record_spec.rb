require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '内容に問題ない場合' do
      it 'postal_code, prefecture_id, municipality, house_number, phone_number, tokenが存在すれば保存ができること' do
        expect(@purchase_record_shipping_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_record_shipping_address.building_name = ''
        expect(@purchase_record_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空では保存できないこと' do
        @purchase_record_shipping_address.postal_code = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが「3桁ハイフン4桁」の半角文字列のみではない場合、保存できないこと' do
        @purchase_record_shipping_address.postal_code = '1234567'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefecture_idが空では保存できないこと' do
        @purchase_record_shipping_address.prefecture_id = 1
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空では保存できないこと' do
        @purchase_record_shipping_address.municipality = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'house_numberが空では保存できないこと' do
        @purchase_record_shipping_address.house_number = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空では保存できないこと' do
        @purchase_record_shipping_address.phone_number = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以内では保存できないこと' do
        @purchase_record_shipping_address.phone_number = '123456789'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが12桁以上では保存できないこと' do
        @purchase_record_shipping_address.phone_number = '123456789012'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが半角数値のみではない場合、保存できないこと' do
        @purchase_record_shipping_address.phone_number = '1a2b3c4d5e'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'tokenが空では保存できないこと' do
        @purchase_record_shipping_address.token = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
