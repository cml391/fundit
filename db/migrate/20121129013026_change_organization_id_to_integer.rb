class ChangeOrganizationIdToInteger < ActiveRecord::Migration
  def up
    if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) and ActiveRecord::Base.connection==ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
        connection.execute(%q{
            alter table follows
            alter column organization_id type integer using cast(organization_id as integer),
            alter column organization_id set default 0
        })
    else
        change_column :follows, :organization_id, :integer, :default => 0
    end
  end

  def down
  	change_column(:follows, :organization_id, :string)
  end
end
