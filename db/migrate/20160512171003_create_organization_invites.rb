class CreateOrganizationInvites < ActiveRecord::Migration
  def change
    create_table :organization_invites do |t|
      t.string :email
      t.belongs_to :organization, index: true
      t.integer :role

      t.timestamps null: false
    end
  end
end
