class AddImageToPlace < ActiveRecord::Migration[8.0]
  def change
    add_column :places, :image, :string
  end
end
