class AddAvatarUrlToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :avatar_url, :string
  end
end
