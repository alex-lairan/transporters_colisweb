module Input
  class CarrierContract < Dry::Validation::Contract
    params do
      required(:name).filled(:str?)
      required(:age).filled(:integer, gteq?: 18)
      required(:has_driver_licence_a).filled(:bool)
      required(:has_driver_licence_b).filled(:bool)
      required(:has_driver_licence_c).filled(:bool)
    end

    rule(:has_driver_licence_a, :has_driver_licence_b, :has_driver_licence_c) do
      has_licence = values[:has_driver_licence_a] || values[:has_driver_licence_b] || values[:has_driver_licence_c]
      key(:driver_licence).failure('must have a driver licence') unless has_licence
    end
  end
end
