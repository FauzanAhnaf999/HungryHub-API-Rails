class MenuItemsController < ApplicationController
  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    base_query = restaurant.menu_items.order(created_at: :desc)
    base_query = base_query.where(category: params[:category]) if params[:category].present?
    if params[:name].present?
      base_query = base_query.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
    end

    page, per_page = pagination_params
    records = base_query.offset((page - 1) * per_page).limit(per_page)

    render json: {
      data: records.as_json,
      meta: pagination_meta(base_query, page, per_page)
    }
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    menu_item = restaurant.menu_items.new(menu_item_params)

    if menu_item.save
      render json: menu_item, status: :created
    else
      render_validation_errors(menu_item)
    end
  end

  def update
    menu_item = MenuItem.find(params[:id])
    if menu_item.update(menu_item_params)
      render json: menu_item
    else
      render_validation_errors(menu_item)
    end
  end

  def destroy
    menu_item = MenuItem.find(params[:id])
    menu_item.destroy
    head :no_content
  end

  private

  def menu_item_params
    params.fetch(:menu_item, params).permit(:name, :description, :price, :category, :is_available)
  end
end
