class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :volunteer_id
      t.string :organization_id

      t.timestamps
    end
  end
end
