class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :volunteer_id
      t.integer :event_id
      t.text :note
      t.integer :goal

      t.timestamps
    end
  end
end
