class ActiveRecord::Base
  # Returns the mass-assignable attributes for a model
  def accessible_attributes
    self.attributes.reject{|k,v| !self.class.accessible_attributes.include?(k)}
  end
end