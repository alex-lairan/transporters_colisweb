class CreateTransporters < ActiveRecord::Migration
  def change
    create_table :transporters do |t|
      t.string :name
      t.string :siret

      t.timestamps null: false
    end
  end
end
