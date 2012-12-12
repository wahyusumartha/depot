require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "product attributes must not be empty" do
    product = Product.new 
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do 
    product = Product.new(title: "My Book Title",
                          description: "Whatever",
                          image_url: 'toting.jpg'
                          )
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join(';')
    
    product.price = 1
    assert product.valid?
  end
  
  def new_product(image_url)
    product = Product.new(title: "My Book", description: "whatever", price: 0.01, image_url: image_url)
  end
  
  test "image url must me .gif, .jpg, or .png" do
    ok = %w{fred.gif fred.jpg fred.png FRED.jpg FRED.Jpg FRED.jPG http://a.b.com/toloy.gif}
    bad = %w{test.doc test.pdf}
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should not be valid"
    end
    
  end
end
