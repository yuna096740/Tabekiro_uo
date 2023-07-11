class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|

      t.integer :reporter_id,  null: false
      t.integer :reported_id,  null: false
      t.integer :genre,        null: false, default: 0
      t.string  :reason,       null: false
      t.integer :is_supported, null: false, default: 0

      t.timestamps
    end
  end
end
