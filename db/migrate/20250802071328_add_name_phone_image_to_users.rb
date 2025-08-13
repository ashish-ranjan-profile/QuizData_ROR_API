class AddNamePhoneImageToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :image, :string
  end
end
