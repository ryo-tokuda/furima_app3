require 'rails_helper'

RSpec.describe PayForm, type: :model do
  before do
    buyer = FactoryBot.create(:user)
    seller = FactoryBot.create(:user)
    item = FactoryBot.build(:item, user_id: seller.id)
    item.image = fixture_file_upload('/sample.png','image/png')
    (sleep 2)
    item.save
    @pay_form = FactoryBot.build(:pay_form,user_id: buyer.id,item_id: item.id)
    # binding.pry
  # 直接@pay_formに[_id]を記述、formobjectはアソシエーションを組めないから
  end
  describe '商品購入' do
    context '内容に問題ない場合'do
      it '全て正常に動く' do
        expect(@pay_form.valid?).to eq true
      end
      it '建物情報があっても保存ができる' do
        @pay_form.building ='丸の内'
        expect(@pay_form.valid?).to eq true
      end
    end
    context '内容に問題がある場合'do
      it 'tokenが必須'do
        @pay_form.token = ''
        @pay_form.valid?
        expect(@pay_form.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが必須'do
      @pay_form.postal_code = ''
      @pay_form.valid?
      expect(@pay_form.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_code:フォーマット通りである' do
      @pay_form.postal_code = '1234567'
      @pay_form.valid?
      expect(@pay_form.errors.full_messages).to include("Postal code is invalid")
    end
    it 'prefectureが必須'do
    @pay_form.prefecture_id =nil
    @pay_form.valid?
    # binding.pry
    expect(@pay_form.errors.full_messages).to include("Prefecture can't be blank")
  end
  it 'prefecutureが0以外のとき'do
  @pay_form.prefecture_id =0
  @pay_form.valid?
  # binding.pry
  expect(@pay_form.errors.full_messages).to include("Prefecture must be other than 0")
    end
    it 'cityが必須'do
    @pay_form.city = ''
    @pay_form.valid?
    # binding.pry
    expect(@pay_form.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが必須' do
    @pay_form.address = ''
    @pay_form.valid?
    # binding.pry
    expect(@pay_form.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが必須' do
    @pay_form.phone_number = ''
    @pay_form.valid?
    # binding.pry
    expect(@pay_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが11桁以内である'do
      @pay_form.phone_number = '12345567891011'
      @pay_form.valid?
      # binding.pry
      expect(@pay_form.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
    end
    it 'phone_number:文字混じり' do
      @pay_form.phone_number = '01234abcde'
      @pay_form.valid?
      # binding.pry
      expect(@pay_form.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end