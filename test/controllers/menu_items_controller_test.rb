require "test_helper"

class MenuItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
    @menu_item = menu_items(:one)
  end

  test "should list restaurant menu items" do
    get "/restaurants/#{@restaurant.id}/menu_items"
    assert_response :success

    json = JSON.parse(response.body)
    assert json["data"].is_a?(Array)
    assert json["meta"].present?
  end

  test "should create menu item for restaurant" do
    assert_difference("MenuItem.count", 1) do
      post "/restaurants/#{@restaurant.id}/menu_items", params: {
        name: "New Item",
        description: "Test",
        price: 10.5,
        category: "main",
        is_available: true
      }, as: :json
    end

    assert_response :created
  end

  test "should update menu item" do
    put "/menu_items/#{@menu_item.id}", params: {
      name: "Updated Item",
      price: 20,
      category: "drink"
    }, as: :json

    assert_response :success
  end

  test "should delete menu item" do
    assert_difference("MenuItem.count", -1) do
      delete "/menu_items/#{@menu_item.id}"
    end

    assert_response :no_content
  end
end
