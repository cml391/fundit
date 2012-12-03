class Donation < ActiveRecord::Base
  attr_accessible :amount, :stripe_token, :message, :name, :is_name_private, :is_amount_private, :is_message_private, :email
  belongs_to :participation

  validates :amount, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :participation_id, :name, :email, :presence => true

  # attr_accessor stripe token so that we can pretend that it's a field,
  # but we don't actually want to save it -- we just use it in charge_customer
  attr_accessor :stripe_token

  before_validation :charge_donor, :on => :create

  # Returns whether or not all of the fields are private
  def all_private
  	return is_name_private &&  is_message_private && is_amount_private
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

  	if all_private
  		share_message = ""
  	end
  	return share_message
  end
  
  def private_history_message
  	private_message = name + " donated $" + amount.to_s
  	return private_message
  end

  private

  # Charges the donor via Stripe
  def charge_donor
    return true unless (self.amount and (self.amount > 0))

    begin
      Stripe::Charge.create({
        # amount is in dollars, stripe takes cents
        :amount => self.amount * 100,
        :currency => "usd",
        :card => self.stripe_token,
        :description => "Donation to #{participation.volunteer.name} for #{participation.event.name}"
      }, self.participation.event.organization.stripe_token)
      return true
    rescue Stripe::StripeError => e
      # Something went wrong. Report that billing failed.
      errors.add(:billing, "Failed: #{e.message}")
      return false
    end
  end

end
