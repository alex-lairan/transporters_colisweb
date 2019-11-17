module Input
  class TransporterContract < Dry::Validation::Contract
    params do
      required(:name).filled(:str?)
      required(:SIRET).filled(:str?)
      required(:postal_codes).array(:str?)
      required(:carriers).value(:array).each { hash(CarrierContract.schema) }
    end

    rule(:carriers).each do
      contract = CarrierContract.new.call(value)
      if contract.errors.any?
        key.failure(contract.errors.messages.map(&:text).join('. '))
      end
    end
  end
end
