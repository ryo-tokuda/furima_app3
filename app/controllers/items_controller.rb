class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user).order("created_at DESC")
  
  end
  
  def new
    @item = Item.new
    # form_withで使用するために定義
  end

  def create
    @item = Item.new(item_params)
    # バリデーションで問題があれば、保存はされず「商品出品画面」を再描画
    if @item.valid?
      @item.save
      return redirect_to root_path
    end
    #  アクションのnewをコールすると、エラ-メッセージが入った@itemが上書きされてしまうので注意
    render 'new'
  end

  private
  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :info,
      :category_id,
      :sales_status_id,
      :shipping_fee_status_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price
    ).merge(user_id: current_user.id)
    # ストロングパラメーターの設定も受講生によって名前が変わります
    # ActiveHashの設定も確認する
  end
end

