class RestaurantsController < ApplicationController
  def index
    page, per_page = pagination_params
    base_query = Restaurant.order(created_at: :desc)
    records = base_query.offset((page - 1) * per_page).limit(per_page)

    render json: {
      data: records.as_json,
      meta: pagination_meta(base_query, page, per_page)
    }
  end

  def show
    restaurant = Restaurant.includes(:menu_items).find(params[:id])
    render json: restaurant.as_json(include: :menu_items)
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render_validation_errors(restaurant)
    end
  end

  def update
    restaurant = Restaurant.find(params[:id])
    if restaurant.update(restaurant_params)
      render json: restaurant
    else
      render_validation_errors(restaurant)
    end
  end

  def destroy
    restaurant = Restaurant.find(params[:id])
    restaurant.destroy
    head :no_content
  end

  private

  def restaurant_params
    params.fetch(:restaurant, params).permit(:name, :address, :phone, :opening_hours)
  end
end
