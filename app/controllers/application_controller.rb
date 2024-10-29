class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from StandardError do |exception|
    render json: { error: exception.message }, status: :bad_request
  end

  def render_not_found_response
    render json: { error: "Resource not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.record.errors }, status: :unprocessable_content
  end
end
