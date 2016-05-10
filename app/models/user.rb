class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  has_many :users_organizations, dependent: :destroy
  has_many :organizations, through: :users_organizations
end
