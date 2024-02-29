class User < ApplicationRecord
  devise :two_factor_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, presence: :true
  validates :email, uniqueness: :true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
  # validates_presence_of :password_digest

  has_many :meetups
  has_many :locations

  # has_secure_password
end
