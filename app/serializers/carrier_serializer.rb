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
