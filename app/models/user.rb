class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :oders

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_ruby, presence: true
  validates :first_name_ruby, presence: true
  validates :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: ' is invalid. Include both letters and numbers'

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ーａ-ｚＡ-Ｚ]+\z/u.freeze
  validates_format_of :last_name, with: NAME_REGEX, message: ' is invalid. Input full-width characters'
  validates_format_of :first_name, with: NAME_REGEX, message: ' is invalid. Input full-width characters'

  RUBY_REGEX = /\A[ァ-ヶー－]+\z/u.freeze
  validates_format_of :last_name_ruby, with: RUBY_REGEX, message: ' Input full-width katakana characters'
  validates_format_of :first_name_ruby, with: RUBY_REGEX, message: ' Input full-width katakana characters'

  # has_many :comments
  # has_many :orders
end
