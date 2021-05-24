class HomeController < ApplicationController
  def index

    if params[:query] == ""

      @nothing = "Hey! You Forgot to Enter a Symbol"
    elsif params[:query]
        begin
        @stock = StockQuote::Stock.quote(params[:query])
        rescue => e
          @error = e
        end
    end
  end

  def about
  end

  def create
  end

end
