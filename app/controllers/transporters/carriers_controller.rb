module Transporters
  class CarriersController < ApplicationController
    def index
      carriers = Carrier.where(transporter_id: params[:transporter_id])

      render json: carriers.to_json
    end
  end
end
