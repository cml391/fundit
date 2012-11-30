class OfflineDonation < ActiveRecord::Base
  attr_accessible :amount, :name, :donation_type, :is_name_private, :is_amount_private, :email
  belongs_to :participation

  validates :amount, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :participation_id, :presence => true
  validates :name, :presence => true
  validates :donation_type, :presence => true

  def all_private
  	return is_name_private && is_amount_private
  end

  def share_history_message
  	share_name = "Anonymous"
  	if is_name_private == false
  		share_name = name
  	end
  	share_message = share_name + " donated"
  	if is_amount_private == false
  		share_message += " $" + amount.to_s
  	end
  	share_message += " by " + donation_type

  	if all_private
  		share_message = ""
  	end
  	return share_message
  end

end
