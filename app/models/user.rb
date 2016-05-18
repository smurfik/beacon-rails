class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_many :users_organizations, dependent: :destroy
  has_many :organizations, through: :users_organizations

  normalize_attribute :email do |value|
    value.downcase
  end
end
