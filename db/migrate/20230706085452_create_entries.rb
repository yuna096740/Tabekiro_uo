class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|

      t.integer :member_id, null: false
      t.integer :room_id,   null: false

      t.timestamps
    end
  end
end
