class Follow < ActiveRecord::Base
  attr_accessible :organization_id, :volunteer_id
  belongs_to :volunteer
  belongs_to :organization
end
