  module Stats
  class TransportersTrackingController < ApplicationController
    def index
      location_filter = { locations: { longitude: params[:longitude], latitude: params[:latitude] } }
      transporters = Transporter.joins(carriers: :locations)
                                .where(location_filter)
                                .preload(:postal_codes)
      carrier_scope = Carrier.joins(:locations).where(location_filter)
      ActiveRecord::Associations::Preloader.new.preload(transporters, :carriers, carrier_scope)

      serializer = FullTransporterSerializer.new

      render json: serializer.call(transporters.to_a)
    end
  end
end
