class AddThankYouSendToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :thank_you_sent, :boolean
  end
end
