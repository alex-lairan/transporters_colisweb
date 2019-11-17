require 'dry/matcher/result_matcher'

module Carriers
  class TrackingsController < ApplicationController
    def create
      result = TrackingForm.new(validator: Input::LocationContract.new).call(params.to_unsafe_h)

      Dry::Matcher::ResultMatcher.call(result) do |m|
        m.success { |transporter| render json: transporter.to_json, status: 201 }
        m.failure(ActiveModel::Errors) { |errors| render_error errors.to_json }
        m.failure { |errors| render_error errors }
      end
    end
  end
end
