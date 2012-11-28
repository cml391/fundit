class AddLastNameToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :last_name, :string
  end
end
