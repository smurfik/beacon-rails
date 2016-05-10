class CreateUsersAndOrganizations < ActiveRecord::Migration
  def change
    create_table :users_organizations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :organization, index: true
      t.boolean :active, default: false
      t.integer :role
    end
  end
end
