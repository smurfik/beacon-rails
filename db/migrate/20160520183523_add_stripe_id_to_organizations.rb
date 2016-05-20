class AddStripeIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :stripe_id, :string
  end
end
