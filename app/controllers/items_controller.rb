class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
  # deviseのヘルパーメソッド。ログインしていなければ、ログイン画面へ遷移させる。
  before_action :set_item, only: [:show,:edit,:update,:destroy]
  # リファクタリング① すでに保存されたデータを取り出す記述
  before_action :move_to_index, only:[:edit,:update,:destroy]
# リファクタリング② ログインしているユーザーと@itemのユーザーの一致確認
#                 異なる場合は、トップページへ遷移させる

  def index
    @items = Item.includes(:user,:order).order("created_at DESC")
  # 一覧機能 出品された順番に表示を行うため、.order以降の記述を追加
  end
  
  def new
    @item = Item.new
    # form_withで使用するために定義
  end

  def create
    @item = Item.new(item_params)
    # バリデーションで問題があれば、保存はされず「商品出品画面」を再描画
    # binding.pry
    if @item.valid?
      @item.save
      return redirect_to root_path
    end
    #  アクションのnewをコールすると、エラ-メッセージが入った@itemが上書きされてしまうので注意
    render 'new'
  end

  def show
    
  end

  def edit
    
  end

  def update
    
    @item.update(item_params)

    if @item.valid?
      redirect_to item_path(@item)
    else
      render 'edit'
        # バリデーションで問題があれば、保存はされず「商品編集画面」を再描画
    end
  end

  def destroy
    @item.destroy 
    redirect_to root_path, notice: '商品を削除しました'
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

  def set_item
    @item = Item.find(params[:id])
    # リファクタリング① すでに保存されたデータを取り出す記述
  end

  def move_to_index
    return redirect_to root_path if current_user.id != @item.user.id
      # リファクタリング② ログインしているユーザーと@itemのユーザーの一致確認
      #                 異なる場合は、トップページへ遷移させる
  end
end

