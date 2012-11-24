class Organization < ActiveRecord::Base
  attr_accessible :bio, :email, :name, :password, :password_confirmation,
                  :stripe_token, :stripe_code, :stripe_pub_key

  has_many :events
  has_secure_password

  #validate :email_must_be_unique
  validates :password, :presence => true, :on => :create
  validates :email, :name, :stripe_token, :presence => true

  # attr_accessor stripe_code so we can use it in the signup form -- we convert
  # a stripe_code (which Stripe gives us when an OAuth request is redirected
  # back to us) to a stripe_token during a before_validation.
  attr_accessor :stripe_code

  before_validation :convert_stripe_code, :on => :create

  private

  # Validation to ensure emails are unique across both Merchants and Customers.
  def email_must_be_unique
    if ((Organization.where(:email => self.email).count > 0) or
        (Volunteer.where(:email => self.email).count > 0))

      errors.add(:email, "is already taken")
    end
  end

  # Convert an OAuth code to a Stripe token we can use to make charges
  def convert_stripe_code
    tokens = STRIPE_OAUTH.auth_code.get_token(self.stripe_code, {
      :headers => {'Authorization' => "Bearer #{STRIPE_KEYS['secret_key']}"}
    })
    self.stripe_token = tokens.token
    self.stripe_pub_key = tokens.params['stripe_publishable_key']

    return true
  end
end
