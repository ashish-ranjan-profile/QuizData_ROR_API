class CreatePlaces < ActiveRecord::Migration[8.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :state
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
