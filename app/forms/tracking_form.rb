class TrackingForm < ApplicationForm
  private

  def on_success(schema)
    location = Location.new latitude: schema[:latitude], longitude: schema[:longitude],
                            altitude: schema[:altitude], carrier_id: schema[:carrier_id]

    if location.save
      Dry::Monads::Success(location)
    else
      Dry::Monads::Failure(location.errors)
    end
  end
end
