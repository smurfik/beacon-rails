class UsersOrganization < ActiveRecord::Base
  validates :user_id, :organization_id, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }

  belongs_to :organization
  belongs_to :user

  enum role: { admin: 0, reviewer: 1 }

  normalize_attribute :role do |value|
    value.to_i
  end
end
