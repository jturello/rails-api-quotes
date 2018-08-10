require 'rails_helper'

describe 'delete quote request' do

  let!(:size) {2} 
  let!(:quotes) {create_list(:quote, size)}
  let!(:id) { quotes[0].id }
  
  it 'deletes one quote' do
    delete "/quotes/#{id}"
    get '/quotes'
    expect(JSON.parse(response.body).size).to eq(size - 1)
  end
end
