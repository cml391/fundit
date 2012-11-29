class Participation < ActiveRecord::Base
  attr_accessible :goal, :note
  belongs_to :event
  belongs_to :volunteer
  has_many :donations
  has_many :offline_donations

  validates :event_id, :uniqueness => {:scope => :volunteer_id}
  validates :goal, :presence => :true, :numericality => {:integer_only => true}
  validates :event_id, :volunteer_id, :presence => true
  
  def donation_sum
    return donations.sum(:amount)
  end
  
  def offline_donation_sum
  	return offline_donations.sum(:amount)
  end
  
  def donation_percent
  	return donations.sum(:amount)*100 / goal
  end
  
  def offline_donation_percent
  	return offline_donations.sum(:amount)*100 / goal
  end
end
