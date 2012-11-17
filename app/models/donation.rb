class Donation < ActiveRecord::Base
  attr_accessible :amount
  belongs_to :participation

  validates :amount, :presence => true, :numericality => {:only_integer => true}
  validates :participation_id, :presence => true
end
