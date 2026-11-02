class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to user_path(@user),
                  notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])

    unless @user == Current.session.user
      redirect_to user_path(Current.session.user)
    end
  end

  def update
    @user = User.find(params[:id])

    unless @user == Current.session.user
      redirect_to user_path(Current.session.user)
      return
    end

    if @user.update(user_params)
      redirect_to user_path(@user),
                  notice: "You have updated user successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email_address,
      :password,
      :password_confirmation,
      :profile_image,
      :introduction
    )
  end
end