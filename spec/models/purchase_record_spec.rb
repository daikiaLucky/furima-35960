require 'rails_helper'

RSpec.describe PurchaseRecord, type: :model do
  before do
    @purcase_record = FactoryBot.build(:purcase_record)
  end

  context '内容に問題ない場合' do
    it "priceとtokenがあれば保存ができること" do
      expect(@purcase_record).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "priceが空では保存ができないこと" do
      @purcase_record.price = nil
      @purcase_record.valid?
      expect(@purcase_record.errors.full_messages).to include("Price can't be blank")
    end

    it "tokenが空では登録できないこと" do
      @purcase_record.token = nil
      @purcase_record.valid?
      expect(@purcase_record.errors.full_messages).to include("Token can't be blank")
    end
  end
end
