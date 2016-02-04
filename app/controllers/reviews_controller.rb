class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]

  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.book_id = @book.id
    
    if @review.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @review.update(review_params)
    redirect_to book_path(@book)
  else
      render 'edit'
    end
  end
  
  def destroy
    if @review.destroy
      redirect_to book_path(@book)
    end
  end

  private
    
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    
    def find_review
      @review = Review.find(params[:id])
    end

    def find_book
      @book = Book.find(params[:book_id])
    end
end