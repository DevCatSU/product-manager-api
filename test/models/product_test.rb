require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "is valid with name and price" do
    product = Product.new(name: "Camera", price: 299.99)
    assert product.valid?
  end

  test "is invalid without a name" do
    product = Product.new(price: 199.99)
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "is invalid with negative price" do
    product = Product.new(name: "Book", price: -5.0)
    assert_not product.valid?
    assert_includes product.errors[:price], "must be greater than or equal to 0"
  end

  test "is valid without description" do
    product = Product.new(name: "Mouse", price: 19.99)
    assert product.valid?
  end
  
  test "available defaults to true" do
    product = Product.new(name: "Webcam", price: 49.99)
    product.save
    assert product.available
  end

end
