class ChangeOfflineDonationTypeColumnName < ActiveRecord::Migration
  def change
  	rename_column :offline_donations, :type, :donation_type
  end
end
