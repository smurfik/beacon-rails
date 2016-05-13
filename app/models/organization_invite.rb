class OrganizationInvite < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: { scope: :organization_id, message: "Person already has been invited." }

  belongs_to :organization
end
