require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
	def new_product(image_url)
		Product.new(title:   "My Book Title",
					description: "yyy",
					price:    1,
					image_url:   image_url)
	end

	test 'product is not valid without a unique title - i18n' do
		product = Product.new(title: products(:ruby).title,
							  description: "yyy",
							  price:  1,
							  image_url:  "fred.gif")
		assert !product.save
		end

	test "image_url is valid" do
		print Product.count;
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}

		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid"
		end
	end



	test 'product attributes must not be empty' do
	  product = Product.new(title:  "My Book Title",
	  						description: "yyy",
	  						image_url: "zzz.jpg")
	  product.price = -1
	  assert product.invalid?
	  assert_equal "must be greater than or equal to 0.01",
	  	product.errors[:price].join('; ')

	  product.price = 0
	  assert product.invalid?
	  assert product.errors[:price].any?
	  assert_equal "must be greater than or equal to 0.01",
	  	product.errors[:price].join('; ')

	  
	  product.price = 1
	  assert product.valid?
	end
end
