class AddPrivacyToDonations < ActiveRecord::Migration
  def change
  	add_column :donations, :message, :string
  	add_column :donations, :name, :string
  	add_column :donations, :is_message_private, :boolean
  	add_column :donations, :is_name_private, :boolean
  	add_column :donations, :is_amount_private, :boolean
  	add_column :offline_donations, :is_name_private, :boolean
  	add_column :offline_donations, :is_amount_private, :boolean
  end
end
