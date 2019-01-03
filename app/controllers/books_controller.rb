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

     name=params[:name]
     author=params[:author]
     publisher = params[:publisher]
     publish_year = params[:publish_year]
     note = params[:note]
     rating = params[:rating]
     
    b=Book.new(:name=>name, :author_id=>author, :publisher_id=>publisher, :note=>note, :publish_year=>publish_year, :user_id=>current_user.id, :rating=>rating)
    
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
