class QuotesController < ApplicationController

  def index 
    @quotes = Quote.all
    json_response(@quotes)
  end

  def show
    @quote = Quote.find(params[:id])
    json_response(@quote)
  end

  def create
    @quote = Quote.create!(quote_params)
    json_response(@quote)
  end

  def update
    @quote = Quote.find(params[:id])
    @quote.update!(quote_params) 
    json_response(@quote)
  end

  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy
    json_response(@quote, :deleted)
  end


  private

  def quote_params
    params.permit(:author, :content)
  end
end
