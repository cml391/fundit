class AddEmailToOfflineDonation < ActiveRecord::Migration
  def change
    add_column :offline_donations, :email, :string
  end
end
