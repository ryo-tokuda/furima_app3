class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item,only: [:index,:create]

  def index
    @item = Item.find(params[:item_id])
    @order = PayForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = PayForm.new(order_params)
    if @order.valid? #バリデーションチェック
      pay_item
      @order.save    #trueなら、フォームオブジェクトのsaveメソッドの呼び出し
      redirect_to root_path  #処理後はリダイレクト
    else
      render 'index'  #indexの再描画
    end

  end
  private

  def order_params
    params.require(:pay_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number
      ).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] #環境変数に合わせる シングルコーテーションとダブルコーテーションに気を付ける
    Payjp::Charge.create(
      amount: @item.price, #決済額の記述
      card: order_params[:token], #カード情報
      currency: 'jpy'             #通貨単位（日本円）
    )
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

end
