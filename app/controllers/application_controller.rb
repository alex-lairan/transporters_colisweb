class ApplicationController < ActionController::Base
  private

  def render_error(body, code = 400)
    render json: { errors: body }, status: code
  end
end
