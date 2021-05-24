class ApplicationController < ActionController::Base
  #StockQuote::Stock.new(api_key: "#{ENV["stock_api_key"]}")
  StockQuote::Stock.new(api_key: "pk_cd2182c6368f4203a3bfd7d7511c4faa")
end
