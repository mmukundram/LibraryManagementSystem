class HomeController < ApplicationController
  def index
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    end
  end
end
