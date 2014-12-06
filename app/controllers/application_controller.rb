class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize
  private 

  	def current_cart
  		Cart.find(session[:cart_id])
  	rescue ActiveRecord::RecordNotFound
  		cart = Cart.create
  		session[:cart_id] = cart.id
  		cart
  	end

    def current_counter
      if session[:counter].nil?
        session[:counter] = 0
      else
        session[:counter] = session[:counter] + 1
      end
    end

    def current_minus
      if session[:minus].nil?
        session[:minus] = 0
      else
        session[:minus] += 1
      end
    end

    protected
      def authorize
        unless User.find_by_id(session[:user_id])
          redirect_to login_url, notice: "Please log in"
        end
      end
end
