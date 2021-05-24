class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :right_user, only: [:edit, :update, :show, :destroy]

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)
    begin
      if StockQuote::Stock.quote(@stock.ticker)
        respond_to do |format|
          if @stock.save
            format.html { redirect_to @stock, notice: "Stock was successfully created." }
            format.json { render :show, status: :created, location: @stock }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @stock.errors, status: :unprocessable_entity }
          end
        end
      end
    rescue => e
      flash.now[:notice] = "This stock is not valid. #{e}"
      render :new
    end

  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock
    begin
      @stock = Stock.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to stocks_path, notice: "#{e}"
    end
  end

  # Only allow a list of trusted parameters through.
  def stock_params
    params.require(:stock).permit(:ticker, :user_id)
  end

  def right_user
    if @stock.user != current_user
      redirect_to stocks_path, notice: "You are not the right user"
    end
  end
end
