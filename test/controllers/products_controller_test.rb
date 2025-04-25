require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = Product.create(
      name: "Smartphone",
      description: "Latest Android phone",
      price: 999.99,
      available: true
    )
  end

  test "should get index" do
    get products_url, as: :json
    assert_response :success
  end

  test "should show product" do
    get product_url(@product), as: :json
    assert_response :success

    body = JSON.parse(@response.body)
    assert_equal @product.name, body["name"]
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: {
        product: {
          name: "Tablet",
          description: "Touchscreen device",
          price: 499.99,
          available: true
        }
      }, as: :json
    end

    assert_response :created
  end

  test "should update product with name and description" do
    patch product_url(@product), params: {
      product: {
        name: "Super Smartphone",
        description: "Updated description",
        price: 899.99
      }
    }, as: :json

    assert_response :success

    @product.reload
    assert_equal "Super Smartphone", @product.name
    assert_equal "Updated description", @product.description
    assert_equal 899.99, @product.price
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product), as: :json
    end
    assert_response :no_content
  end
end
