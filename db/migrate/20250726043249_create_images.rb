class CreateImages < ActiveRecord::Migration[8.0]
  def change
    create_table :images do |t|
      t.string :url
      t.string :imageable_type
      t.integer :imageable_id

      t.timestamps
    end

    add_index :images, [ :imageable_type, :imageable_id ]
  end
end
