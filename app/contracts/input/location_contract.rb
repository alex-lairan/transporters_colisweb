module Input
  class LocationContract < Dry::Validation::Contract
    params do
      required(:latitude).filled(:float)
      required(:longitude).filled(:float)
      required(:altitude).filled(:float)
      required(:carrier_id).filled(:integer)
    end
  end
end
