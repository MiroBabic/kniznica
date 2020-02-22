require 'nokogiri'
require 'mechanize'
require 'openssl'
require 'open-uri'
require 'json'

martinus = "https://www.martinus.sk/?uItem=183781"


page = Nokogiri::HTML(open(martinus))

        #book_data = page.xpath('//script[@type="application/ld+json"][1]')
        book_data = page.at('script[type="application/ld+json"][1]').text
        #preorder_data = page.xpath('//div[@class="card__content"]/p[@class="mb-small text-color-grey-dark"]').text

        #puts book_data

        json_book_data = JSON.parse(book_data)

  #puts json_book_data
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

      puts author_name
      puts publisher_name
      puts price
      puts currency
      puts final_price