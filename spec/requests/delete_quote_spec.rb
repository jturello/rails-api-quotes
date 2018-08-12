require 'rails_helper'

describe 'delete quote request' do

  let!(:size) {3} 
  let!(:quotes) {create_list(:quote, size)}
  let!(:id) { quotes[0].id }
  
  it 'deletes one quote' do
    delete "/api/v1/quotes/#{id}"
    get '/api/v1/quotes'
    expect(JSON.parse(response.body).size).to eq(size - 1)
  end

end
