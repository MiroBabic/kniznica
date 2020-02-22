class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]

  # GET /wishlists
  # GET /wishlists.json
  def index
    @wishlists = Wishlist.all
    @authors = Author.all.order(:name)
    @publishers = Publisher.all.order(:name)
  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new
  end

  # GET /wishlists/1/edit
  def edit
  end

def modal_create_wishlist
    begin

     name=params[:name]
     author=params[:author]
     publisher = params[:publisher]
     publish_year = params[:publish_year]
     note = params[:note]
     martinus_url = params[:martinus_url]
     
    w=Wishlist.new(:name=>name, :author_id=>author, :publisher_id=>publisher, :note=>note, :publish_year=>publish_year, :user_id=>current_user.id, :martinus_url=>martinus_url)
    
    if (w.save)

      respond_to do |format|
        format.json { render :json => {"status":"ok"}  }
      end
    else
      respond_to do |format|
        format.json { render :json => {"status":"nepodarilo sa vložiť záznam"}  }
      end
    end



    rescue => error
      redirect_to wishlists_path, alert: error.message
    end
  end


def modal_edit_wishlist
    begin

      @wishlist = Wishlist.find(params[:wishlistID])

      @wishlist.name=params[:name]
      @wishlist.author_id=params[:author]
      @wishlist.publisher_id = params[:publisher]
      @wishlist.publish_year = params[:publish_year]
      @wishlist.note = params[:note]
      @wishlist.martinus_url = params[:martinus_url]
     
    
    
    if (@wishlist.save)

      respond_to do |format|
        format.json { render :json => {"status":"ok"}  }
      end
    else
      respond_to do |format|
        format.json { render :json => {"status":"nepodarilo sa vložiť záznam"}  }
      end
    end



  rescue => error
    redirect_to wishlists_path, alert: error.message
  end
  end

def update_from_martinus
  require 'nokogiri'
  require 'openssl'
  require 'open-uri'
  require 'json'
  begin
      @wishlists = Wishlist.all

      @wishlists.each do |wishlist|
        #page = Nokogiri::XML(open(wishlist.martinus_url))
        page = Nokogiri::HTML(open(wishlist.martinus_url))

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

       respond_to do |format|
        format.json { render :json => {"status":"ok"}  }
      end      
      

    rescue => error
      redirect_to wishlists_path, :alert=>error.message
#      puts error.message
    end
end

def move_from_wishlist
  begin
    @wishlist = Wishlist.find(params[:wishlist_id])

    @book = Book.new(:name=>@wishlist.name,:author_id=>@wishlist.author_id, :publisher_id=>@wishlist.publisher_id,:note=>@wishlist.note, :publish_year=>@wishlist.publish_year,:user_id=>@wishlist.user_id)

    if (@book.save)
      @wishlist.destroy

      respond_to do |format|
        format.json { render :json => {"status":"ok"}  }
      end
    else
      respond_to do |format|
        format.json { render :json => {"status":"nepodarilo sa presunúť záznam"}  }
      end
    end



  rescue=>error
    redirect_to wishlists_path, :alert=>error.message
  end
end

  # POST /wishlists
  # POST /wishlists.json
  def create
    @wishlist = Wishlist.new(wishlist_params)

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully created.' }
        format.json { render :show, status: :created, location: @wishlist }
      else
        format.html { render :new }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlists/1
  # PATCH/PUT /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @wishlist }
      else
        format.html { render :edit }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: 'Záznam vo wishliste bol úspešne zmazaný.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.require(:wishlist).permit(:name, :author_id, :publisher_id, :publish_year, :martinus_url, :image_url, :note, :pages, :price, :expected_release, :user_id)
    end
end
