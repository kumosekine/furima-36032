class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶー-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :family_name, presence: true
    validates :first_name, presence: true
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー-]+\z/, message: '全角カナを使用してください' } do
    validates :family_name_kana, presence: true
    validates :first_name_kana, presence: true
  end

  validates :birthday, presence: true
  # has_many :items
  # has_many :purchase_records
end
