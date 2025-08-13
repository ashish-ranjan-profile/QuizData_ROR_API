class RemoveImageFromPlace < ActiveRecord::Migration[8.0]
  def change
    remove_column :places, :image, :string
  end
end
