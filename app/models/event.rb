class Event < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :organization
  has_many :participations
  has_many :volunteers, :through => :participations

  validates :name, :organization_id, :date, :presence => true
end
