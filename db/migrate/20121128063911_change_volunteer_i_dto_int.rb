class ChangeVolunteerIDtoInt < ActiveRecord::Migration
  def up
  	case ActiveRecord::Base.connection
    when ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
        connection.execute(%q{
            alter table follows
            alter column volunteer_id type integer using cast(volunteer_id as integer),
            alter column volunteer_id set default 0
        })
    when ActiveRecord::ConnectionAdapters::MySQLAdapter
        change_column :follows, :volunteer_id, :integer, :default => 0
    end
  end

  def down
  	change_column(:follows, :volunteer_id, :string)
  end
end
