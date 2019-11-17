class PostalCodeUnicity < ActiveRecord::Migration
  def change
    add_index(:postal_codes, :code, unique: true)
  end
end
