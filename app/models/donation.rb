class Donation < ActiveRecord::Base
  attr_accessible :amount
  belongs_to :participation

  validates :amount, :presence => true, :numericality => {:only_integer => true}
  validates :participation_id, :presence => true

  # attr_accessor stripe token so that we can pretend that it's a field,
  # but we don't actually want to save it -- we just use it in charge_customer
  attr_accessor :stripe_token

  before_validation :charge_donor, :on => :create

  private

  # Charges the donor via Stripe
  def charge_donor
    begin
      Stripe::Charge.create(
        # amount is in dollars, stripe takes cents
        :amount => self.amount * 100,
        :currency => "usd",
        :customer => self.stripe_token
      )
      return true
    rescue Stripe::StripeError => e
      # Something went wrong. Report that billing failed.
      errors.add(:billing, "Failed: #{e.message}")
      return false
    end
  end
end
