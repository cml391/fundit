class AddLocationAndTimeToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :time, :time
  	add_column :events, :location, :string
  end
end
