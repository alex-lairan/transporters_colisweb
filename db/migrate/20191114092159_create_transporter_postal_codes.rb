class CreateTransporterPostalCodes < ActiveRecord::Migration
  def change
    create_table :transporter_postal_codes do |t|
      t.belongs_to :transporter, index: true, foreign_key: true
      t.belongs_to :postal_code, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
