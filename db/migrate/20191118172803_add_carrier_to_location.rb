class AddCarrierToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :carrier, index: true
    add_foreign_key :locations, :carriers
  end
end
