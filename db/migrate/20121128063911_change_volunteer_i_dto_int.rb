class ChangeVolunteerIDtoInt < ActiveRecord::Migration
  def up
  	change_column(:follows, :volunteer_id, :integer)
  end

  def down
  	change_column(:follows, :volunteer_id, :string)
  end
end
