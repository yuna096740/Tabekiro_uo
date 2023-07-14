class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id
      t.integer :post_comment_id
      t.string  :action,     null: false, default: ''
      t.boolean :checked,    null: false, default: false

      t.timestamps
    end

    add_index :notifications, :visiter_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_id
    add_index :notifications, :post_comment_id
  end
end
