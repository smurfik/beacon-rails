class Organization < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :users_organizations, dependent: :destroy
  has_many :users, through: :users_organizations
end
