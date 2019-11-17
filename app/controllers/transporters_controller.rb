require 'dry/matcher/result_matcher'

class TransportersController < ApplicationController
  def create
    result = TransporterForm.new(validator: Input::TransporterContract.new).call(params.to_unsafe_h)

    Dry::Matcher::ResultMatcher.call(result) do |m|
      m.success { |transporter| render json: transporter.to_json, status: 201 }
      m.failure(ActiveModel::Errors) { |errors| render_error errors.to_json }
      m.failure { |errors| render_error errors }
    end
  end

  def render_error(body, code = 400)
    render json: { errors: body }, status: code
  end
end
