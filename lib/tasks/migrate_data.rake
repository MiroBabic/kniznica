
namespace :migrate_data do
	desc "this task loads typ subjektu"
	task knihy: :environment do

		begin
			#client = Mysql2::Client.new(:host => "mariadb101.websupport.sk", :username => "46sl14y6",:port=>'3312', :database=>"46sl14y6", :password=>ENV['OLD_PHP_DBPASS'], :socket =>'/tmp/mariadb101.sock', encoding: 'utf8', collation: 'utf8_slovak_ci')
			require 'csv'
			file=File.open(Rails.root+'tmp/books_view.csv', "r")
			CSV.foreach(file, encoding: "utf-8", headers: false, :col_sep=>',') do |row|
				

				if row[5] == 'katka'
				 	user_id = 2
				 else
				 	user_id= 1
				 end

				 @publisher = Publisher.where(:name=>row[3]).first_or_create
				 @author = Author.where(:name=>row[2]).first_or_create
				
				 @book = Book.where(:name=>row[1], :author_id=>@author.id, :publisher_id=>@publisher.id, :publish_year=>row[4]).first_or_create
				 @book.rating = row[6]
				 @book.note = row[7]
				 @book.user_id = user_id
				 @book.save

				 puts row[0]
			end

		rescue => error
			puts error.message
		end

	end
end