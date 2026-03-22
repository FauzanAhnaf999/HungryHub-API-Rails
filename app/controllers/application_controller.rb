class ApplicationController < ActionController::API
	before_action :authenticate_api_key!

	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
	rescue_from ActionController::ParameterMissing, with: :render_bad_request

	private

	def authenticate_api_key!
		expected_key = ENV["API_KEY"]
		return if expected_key.blank?

		provided_key = request.headers["X-API-Key"]
		return if ActiveSupport::SecurityUtils.secure_compare(provided_key.to_s, expected_key)

		render json: { error: "Unauthorized" }, status: :unauthorized
	end

	def render_not_found(error)
		render json: { error: error.message }, status: :not_found
	end

	def render_bad_request(error)
		render json: { error: error.message }, status: :bad_request
	end

	def render_validation_errors(record)
		render json: { errors: record.errors.full_messages }, status: :bad_request
	end

	def pagination_params
		page = params.fetch(:page, 1).to_i
		per_page = params.fetch(:per_page, 10).to_i

		page = 1 if page < 1
		per_page = 10 if per_page < 1
		per_page = 100 if per_page > 100

		[page, per_page]
	end

	def pagination_meta(relation, page, per_page)
		total_count = relation.count
		{
			page: page,
			per_page: per_page,
			total_count: total_count,
			total_pages: (total_count.to_f / per_page).ceil
		}
	end
end
