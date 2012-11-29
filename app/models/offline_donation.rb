class OfflineDonation < ActiveRecord::Base
  attr_accessible :amount, :name, :type
  belongs_to :participation
  
  validates :amount, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}
  validates :participation_id, :presence => true
  validates :name, :presence => true
  validates :type, :presence => true
  
end
