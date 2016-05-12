class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :users_organizations, dependent: :destroy
  has_many :users, through: :users_organizations
  has_many :organization_invites
end
