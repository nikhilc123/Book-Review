class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  
  def index
    #if you do not search by a category name(passing no parameters), display all books(index page) else search by name)
    if params[:category].blank?
      @books = Book.all.order('created_at DESC')
    else
      # @category_id = Category.find_by(name: params[:category]).id
       @category_id = Category.find_by_name(params[:category]).id #example: checks technology.id = category.id
      @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
  end
  
  def show
  end
  
  def new
    @book = current_user.books.build
    @categories = Category.all.map {|c| [c.name, c.id] }
  end
  
  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]
    
    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @categories = Category.all.map {|c| [c.name, c.id] }
  end
  
  def update
    if @book.update(book_params)
      redirect_to book_path
    else
      render 'edit'
    end
  end
  
  def destroy
    if @book.destroy
      redirect_to root_path
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
    end
    
    def find_book
      @book = Book.find(params[:id])
    end
end
