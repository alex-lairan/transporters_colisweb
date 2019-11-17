class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.integer :age
      t.boolean :has_driver_licence_a
      t.boolean :has_driver_licence_b
      t.boolean :has_driver_licence_c
      t.belongs_to :transporter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
