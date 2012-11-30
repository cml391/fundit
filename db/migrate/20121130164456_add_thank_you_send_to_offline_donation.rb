class AddThankYouSendToOfflineDonation < ActiveRecord::Migration
  def change
    add_column :offline_donations, :thank_you_sent, :boolean
  end
end
