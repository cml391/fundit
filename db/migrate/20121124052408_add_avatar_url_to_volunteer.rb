class AddAvatarUrlToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :avatar_url, :string
  end
end
