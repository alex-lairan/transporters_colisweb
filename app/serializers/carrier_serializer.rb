# == Schema Information
#
# Table name: carriers
#
#  id                   :integer          not null, primary key
#  name                 :string
#  age                  :integer
#  has_driver_licence_a :boolean
#  has_driver_licence_b :boolean
#  has_driver_licence_c :boolean
#  transporter_id       :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class CarrierSerializer < ApplicationSerializer
  private

  def serialize_element(element)
    {
        name: element.name,
        age: element.age,
        has_driver_licence_a: element.has_driver_licence_a,
        has_driver_licence_b: element.has_driver_licence_b,
        has_driver_licence_c: element.has_driver_licence_c,
    }
  end
end
