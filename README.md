# HungryHub - Restaurant Menu Management API (Ruby on Rails)

REST API for managing restaurants and their menu items, built for the HungryHub take-home assignment.

## Quick Start (2-3 Minutes)

### Option A: Run with Docker (Fastest)

1. Copy the environment file:

	`cp .env.example .env`

2. Build and run:

	`docker compose up --build`

3. API is available at:

	`http://localhost:3000`

### Option B: Run with Native Ruby

1. Install dependencies:

	`bundle install`

2. Set up the database:

	`bin/rails db:prepare`

3. Seed data:

	`bin/rails db:seed`

4. Start the server:

	`bin/rails server`

5. API is available at:

	`http://localhost:3000`

## Tech Stack

- Ruby 3.3.6
- Rails 8.1 (API mode)
- SQLite (development/test)
- Minitest (integration tests)
- Docker + Docker Compose (local run)

## Features Implemented

### Must-Have

- Full required data models and relationship:
  - `Restaurant has_many :menu_items`
  - `MenuItem belongs_to :restaurant`
- Required endpoints with proper HTTP status codes
- Input validation with clear JSON error messages
- Database constraints (non-null, foreign key, defaults)
- Seed data (2 restaurants, 10 menu items total)
- Clear setup and usage documentation

### Nice-to-Have

- API key authentication (optional, via env `API_KEY` and header `X-API-Key`)
- Pagination (`page`, `per_page`) on list endpoints
- Filter/search menu items by `category` and `name`
- Basic integration test coverage
- Docker setup for easy local run

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/restaurants` | Create a restaurant |
| GET | `/restaurants` | List all restaurants (paginated) |
| GET | `/restaurants/:id` | Get restaurant details (includes menu items) |
| PUT | `/restaurants/:id` | Update a restaurant |
| DELETE | `/restaurants/:id` | Delete a restaurant |
| POST | `/restaurants/:id/menu_items` | Add a menu item |
| GET | `/restaurants/:id/menu_items` | List menu items (supports filter/search/pagination) |
| PUT | `/menu_items/:id` | Update a menu item |
| DELETE | `/menu_items/:id` | Delete a menu item |

## API Conventions

- Local base URL: `http://localhost:3000`
- JSON headers:
	- `Content-Type: application/json`
	- `Accept: application/json`
- Authentication is optional:
	- If `API_KEY` is set, include the `X-API-Key` header
	- If `API_KEY` is not set, endpoints remain publicly accessible

### Pagination

- Parameters: `page` (default `1`), `per_page` (default `10`, max `100`)
- List responses always include:

```json
{
	"data": [],
	"meta": {
		"page": 1,
		"per_page": 10,
		"total_count": 25,
		"total_pages": 3
	}
}
```

### Error Format

- Not found (`404`):

```json
{ "error": "Couldn't find Restaurant with 'id'=999" }
```

- Bad request / validation (`400`):

```json
{ "errors": ["Name can't be blank", "Address can't be blank"] }
```

- Unauthorized (`401`, when API key auth is enabled):

```json
{ "error": "Unauthorized" }
```

## Postman Collection

- Collection: `postman/HungryHub-API-Rails.postman_collection.json`
- Environment: `postman/HungryHub-API-Rails.local.postman_environment.json`

Import both into Postman, select the `HungryHub API Rails Local` environment, then run requests in order from `Restaurants` -> `Menu Items` -> `Cleanup`.

## Query Parameters

For list endpoints:

- `page` (default `1`)
- `per_page` (default `10`, max `100`)

For menu item list:

- `category` (e.g. `appetizer`, `main`, `dessert`, `drink`)
- `name` (case-insensitive partial search)

Example:

`GET /restaurants/1/menu_items?category=main&name=thai&page=1&per_page=5`

## Quick Request Examples (cURL)

### Create Restaurant

```bash
curl -X POST http://localhost:3000/restaurants \
	-H "Content-Type: application/json" \
	-H "Accept: application/json" \
	-d '{
		"name": "Sunset Grill",
		"address": "10 Main Street",
		"phone": "1234567890",
		"opening_hours": "09:00-21:00"
	}'
```

### List Menu Items + Filter + Pagination

```bash
curl "http://localhost:3000/restaurants/1/menu_items?category=main&name=chicken&page=1&per_page=5" \
	-H "Accept: application/json"
```

## Authentication (Optional)

If the `API_KEY` environment variable is set, all requests must include:

`X-API-Key: <your_api_key>`

If `API_KEY` is not set, authentication is skipped (useful for quick local testing).

You can copy `.env.example` to `.env` and set `API_KEY` there.

## Run Locally (Without Docker)

1. Install dependencies:

	`bundle install`

2. Prepare DB:

	`bin/rails db:prepare`

3. Seed DB:

	`bin/rails db:seed`

4. Start server:

	`bin/rails server`

Server runs at `http://localhost:3000`.

> Tip: for automated setup, you can run `bin/setup --skip-server`.

## Run with Docker Compose

1. Build and run:

	`docker compose up --build`

2. App is available at `http://localhost:3000`.

## Run Tests

`bin/rails test`

## Design Decisions

- Rails API mode for lightweight JSON REST behavior
- Support for both flat and nested JSON payloads for convenience
- Global error handling in `ApplicationController`:
  - `404` for missing records
  - `400` for invalid payload/validation errors
  - `401` for invalid API key (when enabled)
- Pagination metadata included in list responses for frontend consumption

## Project Structure (Summary)

- `app/controllers` → request handling and JSON responses
- `app/models` → relationships and data validations
- `config/routes.rb` → REST endpoint routing
- `db/seeds.rb` → initial sample data
- `test/controllers` and `test/models` → basic regression checks

## Notes for Reviewer

- No secrets are committed to the repository
- `config/*.key` is ignored by git
- This repo is ready to clone and run with either native Ruby or Docker Compose
