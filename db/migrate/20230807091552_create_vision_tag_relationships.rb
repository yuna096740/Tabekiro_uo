class CreateVisionTagRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :vision_tag_relationships do |t|

      t.timestamps
    end
  end
end
