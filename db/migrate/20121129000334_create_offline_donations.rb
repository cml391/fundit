class CreateOfflineDonations < ActiveRecord::Migration
  def change
    create_table :offline_donations do |t|
      t.integer :amount
      t.string :name
      t.string :type
      t.integer :participation_id

      t.timestamps
    end
  end
end
