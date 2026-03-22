require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should list restaurants" do
    get "/restaurants"
    assert_response :success

    json = JSON.parse(response.body)
    assert json["data"].is_a?(Array)
    assert json["meta"].present?
  end

  test "should show restaurant with menu items" do
    get "/restaurants/#{@restaurant.id}"
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal @restaurant.name, json["name"]
    assert json["menu_items"].is_a?(Array)
  end

  test "should create restaurant" do
    assert_difference("Restaurant.count", 1) do
      post "/restaurants", params: {
        name: "Test Resto",
        address: "Test Address",
        phone: "123",
        opening_hours: "08:00-20:00"
      }, as: :json
    end

    assert_response :created
  end
end
