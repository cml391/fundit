class Organization < ActiveRecord::Base
  attr_accessible :bio, :email, :name, :password, :password_confirmation, :stripe_token
  has_many :events
  has_secure_password

  #validate :email_must_be_unique
  validates :password, :presence => true, :on => :create
  validates :email, :name, :stripe_token, :presence => true

  # Validation to ensure emails are unique across both Merchants and Customers.
  def email_must_be_unique
    if ((Organization.where(:email => self.email).count > 0) or
        (Volunteer.where(:email => self.email).count > 0))

      errors.add(:email, "is already taken")
    end
  end
end
