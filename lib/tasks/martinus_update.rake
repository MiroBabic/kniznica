
require 'nokogiri'
require 'openssl'
require 'open-uri'
require 'json'

namespace :martinus_update do
	desc "this task updates contact names"
	task wishlist: :environment do

		begin
			@wishlists = Wishlist.all

			@wishlists.each do |wishlist|
				page = Nokogiri::XML(open(wishlist.martinus_url))

				book_data = page.xpath('//script[@type="application/ld+json"][1]').text
				preorder_data = page.xpath('//div[@class="card__content"]/p[@class="mb-small text-color-grey-dark"]').text

				json_book_data = JSON.parse(book_data)

				publisher_name = ''
				json_book_data["publisher"].each do |publisher|
					publisher_name = publisher["name"]
				end

				author_name = ''

				json_book_data["author"].each do |author|
					author_name = author["name"]
				end

				price = json_book_data["offers"]["price"]
				currency = json_book_data["offers"]["priceCurrency"]
				final_price = (price.to_s) +' '+(currency.to_s)
				

				@author = Author.where(:name=>author_name.strip).first_or_create
				@publisher = Publisher.where(:name=>publisher_name.strip).first_or_create

				if preorder_data.present?
					expected_release = preorder_data
				else
					expected_release = 'Už vydané alebo bude čoskoro'
				end


					wishlist.name = json_book_data["name"]
					wishlist.pages = json_book_data["numberOfPages"]
					wishlist.image_url = json_book_data["thumbnailUrl"]
					wishlist.author_id = @author.id
					wishlist.publisher_id = @publisher.id
					wishlist.expected_release = expected_release
					wishlist.price = final_price
					wishlist.save

			
			end
			

		rescue => error
			puts error.message
		end

	end
end