class FullTransporterSerializer < ApplicationSerializer
  private

  def serialize_element(element)
    {
      name: element.name,
      SIRET: element.siret,
      postal_code: element.postal_codes.map(&:code),
      carriers: CarrierSerializer.new.call(element.carriers.to_a)
    }
  end
end
