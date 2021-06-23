class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def new
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_recoed_params)
    if @purchase_record_shipping_address.valid?
      @purchase_record_shipping_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record_shipping_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, :item_id).merge(user_id: current_user.id)
  end

end
