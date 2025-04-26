require 'rails_helper'

RSpec.describe "Products API", type: :request do
  it "creates, reads, updates, and deletes a product" do
    # 1. Create
    post "/products", params: { product: { name: "Test Product", description: "Test Description", price: 10.0, available: true } }
    expect(response).to have_http_status(:created)

    product = JSON.parse(response.body)

    # 2. Read
    get "/products/#{product["id"]}"
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["name"]).to eq("Test Product")

    # 3. Update
    patch "/products/#{product["id"]}", params: { product: { price: 20.0 } }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["price"].to_f).to eq(20.0)
       
    # 4. Delete
    delete "/products/#{product["id"]}"
    expect(response).to have_http_status(:no_content)
  end
end