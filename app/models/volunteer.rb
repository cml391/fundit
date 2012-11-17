class Volunteer < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_many :participations
  has_many :events, :through => :participations
  has_secure_password

  validate :email_must_be_unique
  validates :password, :presence => true, :on => :create
  validates :email, :name, :presence => true

  # Validation to ensure emails are unique across both Merchants and Customers.
  def email_must_be_unique
    if ((Organization.where(:email => self.email).count > 0) or
        (Volunteer.where(:email => self.email).count > 0))

      errors.add(:email, "is already taken")
    end
  end
end
