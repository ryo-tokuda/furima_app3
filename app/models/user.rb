class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

    # アソシエーション設定
    has_many :items
    has_many :orders

    # <<バリデーション>>
    with_options presence: true do
      validates :nickname
      validates :birth_date

    # パスワードの英数字混在を否定
      PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
      validates_format_of :password,with: PASSWORD_REGEX

    # 全角のひらがな or 漢字以外を使用していないかの検証
    with_options format: {with: /\A[ぁ-んァ-ン一-龥々]+\z/} do
      validates :first_name
      validates :last_name
    end

    # 全角のカタカナ以外を使用していないの検証
    with_options format: { with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/} do
      validates :first_name_kana
      validates :last_name_kana
    end
      
      end
    end
