class AddBioToVolunteer < ActiveRecord::Migration
  def change
  	add_column :volunteers, :bio, :string
  end
end
