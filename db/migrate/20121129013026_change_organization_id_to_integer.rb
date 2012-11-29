class ChangeOrganizationIdToInteger < ActiveRecord::Migration
  def up
    if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) and ActiveRecord::Base.connection==ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
        connection.execute(%q{
            ALTER TABLE follows ALTER COLUMN organization_id DROP DEFAULT;
						ALTER TABLE follows ALTER COLUMN organization_id TYPE integer
  					USING CAST(organization_id as INTEGER);
						ALTER TABLE follows ALTER COLUMN organization_id SET DEFAULT 0;
        })
    else
        change_column :follows, :organization_id, :integer, :default => 0
    end
  end

  def down
  	change_column(:follows, :organization_id, :string)
  end
end
