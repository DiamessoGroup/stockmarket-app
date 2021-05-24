class ApplicationController < ActionController::Base
  StockQuote::Stock.new(api_key: "#{ENV["stock_api_key"]}")
end
