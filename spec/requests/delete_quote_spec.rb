require 'rails_helper'

describe 'delete quote request' do

  let!(:size) {2} 
  let!(:quotes) {create_list(:quote, size)}
  let!(:valid_id) { quotes.first.id }
  let!(:invalid_id) { quotes.inject(0) {|sum, quote| sum + quote.id}}

  context 'with a valid input' do
    it 'deletes a quote' do
      delete "/api/v1/quotes/#{valid_id}"
      get '/api/v1/quotes'
      expect(json.size).to eq(size - 1)
    end
  end

  context 'with invalid input' do
    it 'returns status 404 - :not_found' do
      delete "/api/v1/quotes/#{invalid_id}"
      expect(response).to have_http_status(:not_found)
    end
  end
end
