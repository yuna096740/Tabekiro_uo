class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :member_id,    null: false
      t.integer :tag_id,       null: false
      t.string  :title,        null: false
      t.string  :introduction, null: false
      t.integer :limit,        null: false, default: 0
      t.float   :latitude,     null: false
      t.float   :longitube,    null: false
      t.string  :place_name,   null: false
      t.boolean :is_open,      null: false, default: true

      t.timestamps
    end
  end
end
