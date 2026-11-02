class BooksController < ApplicationController
  def index
    @user = Current.session.user
    @book = Book.new
    @books = Book.includes(:user).all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = Current.session.user

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @user = Current.session.user
      @books = Book.all
      render "index", status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])

    unless @book.user == Current.session.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    unless @book.user == Current.session.user
      redirect_to books_path
      return
    end

    if @book.update(book_params)
      redirect_to book_path(@book),
                  notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])

    unless @book.user == Current.session.user
      redirect_to books_path
      return
    end

    @book.destroy

    redirect_to books_path,
                notice: "You have deleted book successfully."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end