module Stats
  class CarriersTrackingController < ApplicationController
    def index
      carriers = Carrier.joins(:locations)
                        .where(locations: { longitude: params[:longitude], latitude: params[:latitude] })
      serializer = CarrierSerializer.new

      render json: serializer.call(carriers.to_a)
    end
  end
end
