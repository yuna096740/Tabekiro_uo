class CreateVisionTagRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :vision_tag_relationships do |t|
      t.integer :post_id,       null: false
      t.integer :vision_tag_id, null: false

      t.timestamps
    end
  end
end
