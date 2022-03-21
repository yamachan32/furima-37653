class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_ruby, presence: true
  validates :first_name_ruby, presence: true
  validates :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は文字と数字の両方を含めてください'

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ーａ-ｚＡ-Ｚ]+\z/u.freeze
  validates_format_of :last_name, with: NAME_REGEX, message: 'は全角文字で入力してください'
  validates_format_of :first_name, with: NAME_REGEX, message: 'は全角文字で入力してください'

  RUBY_REGEX = /\A[ァ-ヶー－]+\z/u.freeze
  validates_format_of :last_name_ruby, with: RUBY_REGEX, message: 'は全角カナで入力してください'
  validates_format_of :first_name_ruby, with: RUBY_REGEX, message: 'は全角カナで入力してください'
end
