class AddStripePubKeyToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :stripe_pub_key, :string
  end
end
