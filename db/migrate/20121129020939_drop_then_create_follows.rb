class DropThenCreateFollows < ActiveRecord::Migration
  def up
  	drop_table :follows if table_exists?(:follows)
  	create_table :follows do |t|
      t.integer :volunteer_id
      t.integer :organization_id

      t.timestamps
    end
  end

  def down
  end

  def self.table_exists?(name)
    ActiveRecord::Base.connection.tables.include?(name)
  end
end
