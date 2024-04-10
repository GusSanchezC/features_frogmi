class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      # t.string :feature_id, null: false Solucion para utilizar el id del sismo en lugar del id por defecto
      t.references :feature, null: false, foreign_key: true
      t.text :body
    t.timestamps
    end
  end
end
