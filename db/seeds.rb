MenuItem.delete_all
Restaurant.delete_all

restaurants_data = [
	{
		name: "Siam Spice Kitchen",
		address: "123 Sukhumvit Rd, Bangkok",
		phone: "+66-2-123-4567",
		opening_hours: "10:00-22:00",
		menu_items: [
			{ name: "Tom Yum Soup", description: "Spicy and sour shrimp soup", price: 129.00, category: "appetizer", is_available: true },
			{ name: "Pad Thai", description: "Classic stir-fried noodles", price: 149.00, category: "main", is_available: true },
			{ name: "Green Curry", description: "Chicken green curry with coconut milk", price: 169.00, category: "main", is_available: true },
			{ name: "Mango Sticky Rice", description: "Sweet coconut sticky rice and mango", price: 99.00, category: "dessert", is_available: true },
			{ name: "Thai Iced Tea", description: "Traditional sweet Thai milk tea", price: 59.00, category: "drink", is_available: true }
		]
	},
	{
		name: "Riverfront Grill",
		address: "88 Charoen Krung Rd, Bangkok",
		phone: "+66-2-987-6543",
		opening_hours: "11:00-23:00",
		menu_items: [
			{ name: "Garlic Bread", description: "Toasted baguette with garlic butter", price: 79.00, category: "appetizer", is_available: true },
			{ name: "Grilled Salmon", description: "Salmon fillet with lemon butter", price: 259.00, category: "main", is_available: true },
			{ name: "Steak Frites", description: "Sirloin steak with fries", price: 329.00, category: "main", is_available: false },
			{ name: "Chocolate Lava Cake", description: "Warm chocolate cake with molten center", price: 119.00, category: "dessert", is_available: true },
			{ name: "Sparkling Lemonade", description: "House-made sparkling lemonade", price: 69.00, category: "drink", is_available: true }
		]
	}
]

restaurants_data.each do |restaurant_data|
	menu_items = restaurant_data.delete(:menu_items)
	restaurant = Restaurant.create!(restaurant_data)
	menu_items.each { |item| restaurant.menu_items.create!(item) }
end

puts "Seed completed: #{Restaurant.count} restaurants and #{MenuItem.count} menu items created."
