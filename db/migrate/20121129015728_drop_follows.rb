class DropFollows < ActiveRecord::Migration
def up
    drop_table :follows if self.table_exists?("follows")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
