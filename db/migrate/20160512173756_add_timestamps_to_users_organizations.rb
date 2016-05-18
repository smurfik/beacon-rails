class AddTimestampsToUsersOrganizations < ActiveRecord::Migration
  def change
    add_column :users_organizations, :created_at, :datetime
    add_column :users_organizations, :updated_at, :datetime
  end
end
