class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_recoed_params)
    if @purchase_record_shipping_address.valid?
      pay_item
      @purchase_record_shipping_address.save!
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record_shipping_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end

end
