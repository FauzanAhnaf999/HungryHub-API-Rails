# HungryHub - Restaurant Menu Management API (Ruby on Rails)

REST API for managing restaurants and their menu items, built for HungryHub take-home assignment.

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
- Database constraints (non-null, FK, defaults)
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
| GET | `/restaurants/:id` | Get restaurant detail (includes menu items) |
| PUT | `/restaurants/:id` | Update a restaurant |
| DELETE | `/restaurants/:id` | Delete a restaurant |
| POST | `/restaurants/:id/menu_items` | Add a menu item |
| GET | `/restaurants/:id/menu_items` | List menu items (supports filter/search/pagination) |
| PUT | `/menu_items/:id` | Update a menu item |
| DELETE | `/menu_items/:id` | Delete a menu item |

## Postman Collection

- Collection: `postman/HungryHub-API-Rails.postman_collection.json`
- Environment: `postman/HungryHub-API-Rails.local.postman_environment.json`

Import keduanya ke Postman, pilih environment `HungryHub API Rails Local`, lalu jalankan request berurutan dari folder `Restaurants` -> `Menu Items` -> `Cleanup`.

## Query Parameters

For list endpoints:

- `page` (default `1`)
- `per_page` (default `10`, max `100`)

For menu item list:

- `category` (e.g. `appetizer`, `main`, `dessert`, `drink`)
- `name` (case-insensitive partial search)

Example:

`GET /restaurants/1/menu_items?category=main&name=thai&page=1&per_page=5`

## Authentication (Optional)

If `API_KEY` env var is set, all requests must include:

`X-API-Key: <your_api_key>`

If `API_KEY` is not set, auth is skipped (useful for quick local testing).

You can copy `.env.example` as `.env` and set `API_KEY` there.

## Run Locally (Without Docker)

1. Install dependencies:

	`bundle install`

2. Prepare DB:

	`bin/rails db:prepare`

3. Seed DB:

	`bin/rails db:seed`

4. Start server:

	`bin/rails server`

Server runs on `http://localhost:3000`.

## Run with Docker Compose

1. Build and run:

	`docker compose up --build`

2. App is available at `http://localhost:3000`.

## Run Tests

`bin/rails test`

## Design Decisions

- API mode Rails for lightweight JSON REST behavior.
- Flat JSON payload support and nested payload support for convenience.
- Global error handling in `ApplicationController`:
  - `404` for missing records
  - `400` for invalid payload/validation errors
  - `401` for invalid API key (when enabled)
- Pagination meta included in list responses to support frontend consumption.

## Notes for Reviewer

- No secrets are committed to repository.
- `config/*.key` is ignored by git.
- This repo is ready to clone and run with either native Ruby or Docker Compose.
