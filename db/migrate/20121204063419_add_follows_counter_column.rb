class AddFollowsCounterColumn < ActiveRecord::Migration
	def self.up  
    add_column :organizations, :follows_count, :integer, :default => 0  
      
    Organization.reset_column_information
  	Organization.find_each do |u|
    	Organization.reset_counters u.id, :follows
  	end  
  end  
  
  def self.down  
    remove_column :organizations, :follows_count  
  end  
end
