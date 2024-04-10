class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :_id, null: false
      t.float :mag
      t.string :place, null: false
      t.datetime :time
      t.string :url, null: false
      t.boolean :tsunami
      t.string :mag_type
      t.string :title, null: false
      # t.decimal :longitude, precision: 9, scale: 6, null: false 
      # t.decimal :latitude, precision: 8, scale: 6, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.timestamps
    end
    add_index :features, :_id, unique: true
  end
end
