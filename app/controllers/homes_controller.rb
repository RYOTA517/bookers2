class HomesController < ApplicationController
  allow_unauthenticated_access

    def top
      if authenticated?
        @user = Current.session.user
        @book = Book.new
        @books = Book.includes(:user).all
      end
    end


    def about
    end

end