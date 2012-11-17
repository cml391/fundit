class Participation < ActiveRecord::Base
  attr_accessible :goal, :note
  belongs_to :event
  belongs_to :volunteer
  has_many :donations

  validates :event_id, :uniqueness => {:scope => :volunteer_id}
  validates :goal, :presence => :true, :numericality => {:integer_only => true}
  validates :event_id, :volunteer_id, :presence => true
end
