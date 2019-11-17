module Stats
  class TransportersPostalCodesController < ApplicationController
    def index
      serializer = FullTransporterSerializer.new

      data = PostalCode.preload(transporters: [:carriers, :postal_codes])
                       .each_with_object({}) { |postal_code, acc| acc[postal_code.code] = postal_code.transporters.to_a }
                       .map { |k, v| { postal_code: k, transporters: serializer.call(v) } }
      render json: data
    end
  end
end
