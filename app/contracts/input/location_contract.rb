module Input
  class LocationContract < Dry::Validation::Contract
    params do
      required(:latitude).filled(:float)
      required(:longitude).filled(:float)
      required(:altitude).filled(:float)
    end
  end
end
