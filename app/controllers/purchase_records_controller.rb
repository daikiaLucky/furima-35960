class PurchaseRecordsController < ApplicationController
  def index
    @purchase_record = PurchaseRecord.new
    @item = Item.find(params[:item_id]) 
  end

  def create
  end

  def purchase_record_params
    params.require(:purchase_record).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name,
                                            :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
