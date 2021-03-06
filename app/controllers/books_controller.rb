class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    @authors = Author.all.order(:name)
    @publishers = Publisher.all.order(:name)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  def modal_create_book
    begin

    require 'nokogiri'

    require 'openssl'
    require 'open-uri'
    require 'json'



     name=params[:name]
     author=params[:author]
     publisher = params[:publisher]
     publish_year = params[:publish_year]
     note = params[:note]
     rating = params[:rating]
     martinus = params[:martinus]

     if params[:author_name].present?
      #a = Author.new(:name=>params[:author_name])
      a = Author.where(:name => params[:author_name]).first_or_create
      a.save
      author = a.id
     end

     if martinus.present?
   

      #page = Nokogiri::XML(open(martinus))
      page = Nokogiri::HTML(open(martinus))

        #book_data = page.xpath('//script[@type="application/ld+json"][1]').text
        book_data = page.at('script[type="application/ld+json"]').text
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

        hh=Hash.new
        hh[:pages] = json_book_data["numberOfPages"]
        hh[:thumbnail] = json_book_data["thumbnailUrl"]
        hh[:price] = final_price

       b=Book.new(:name=>json_book_data["name"], :author_id=>@author.id, :publisher_id=>@publisher.id, :user_id=>current_user.id, :martinus_url=>martinus, :martinus_data=>hh) 

        
     else


     
        b=Book.new(:name=>name, :author_id=>author, :publisher_id=>publisher, :note=>note, :publish_year=>publish_year, :user_id=>current_user.id, :rating=>rating)
      end
    
    if (b.save)

      respond_to do |format|
        format.json { render :json => {"status":"ok"}  }
      end
    else
      respond_to do |format|
        format.json { render :json => {"status":"nepodarilo sa vložiť záznam"}  }
      end
    end



    rescue => error
      redirect_to books_path, alert: error.message
    end
  end

  def modal_edit_book
    begin

      @book = Book.find(params[:bookID])

      @book.name=params[:name]
      @book.author_id=params[:author]
      @book.publisher_id = params[:publisher]
      @book.publish_year = params[:publish_year]
      @book.note = params[:note]
      @book.rating = params[:rating]
      @book.martinus_url = params[:martinus]
     
    
    
    if (@book.save)

      respond_to do |format|
        format.json { render :json => {"status":"ok"}  }
      end
    else
      respond_to do |format|
        format.json { render :json => {"status":"nepodarilo sa vložiť záznam"}  }
      end
    end



  rescue => error
    redirect_to books_path, alert: error.message
  end
  end

  def chart_total_books

    @result = Book.joins(:user).select("count(1) as value, users.name as label").group("users.name")           
              
    respond_to do |format|
      format.json {
        #render json: (status:"ok" , @result.to_json(:only=> [:label, :value]))
         render :json => {"status": "ok", "data": @result.to_json(:only=> [:label, :value]) }  
      }
    end

  end

  def chart_top_book_publishers
    @result = Book.joins(:publisher).select("count(1) as value, publishers.name as publisher_name").group("publishers.name").order("value desc").limit(10)

    respond_to do |format|
      format.json {
        #render json: (status:"ok" , @result.to_json(:only=> [:label, :value]))
         render :json => {"status": "ok", "data": @result.to_json(:only=> [:value, :publisher_name]) }  
      }
    end

  end

  def chart_top_book_authors
    @result = Book.joins(:author).select("count(1) as value, authors.name as author_name").group("authors.name").order("value desc").limit(10)

    respond_to do |format|
      format.json {
        #render json: (status:"ok" , @result.to_json(:only=> [:label, :value]))
         render :json => {"status": "ok", "data": @result.to_json(:only=> [:value, :author_name]) }  
      }
    end

  end


  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Kniha bola úspešne zmazaná.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :author, :publisher, :publish_year, :rating, :note)
    end
end
