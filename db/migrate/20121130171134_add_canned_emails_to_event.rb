class AddCannedEmailsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :thank_you_email, :text
    add_column :events, :solicit_email, :text
  end
end
