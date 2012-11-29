class DropThenCreateFollows < ActiveRecord::Migration
  def up
  	create_table :follows do |t|
      t.integer :volunteer_id
      t.integer :organization_id

      t.timestamps
    end
  end

  def down
  end
end
