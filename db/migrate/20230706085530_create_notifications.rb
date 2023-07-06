class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id
      t.integer :post_comment_id
      t.string  :action,     null: false
      t.boolean :checked,    null: false

      t.timestamps
    end
  end
end
