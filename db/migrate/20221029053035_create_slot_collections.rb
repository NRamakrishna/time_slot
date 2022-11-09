class CreateSlotCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :slot_collections do |t|
      t.integer :slot_id
      t.integer :capacity
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
