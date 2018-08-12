require 'rails_helper' 

describe "get quotes", :type => :request do
  let!(:size) {2} 
  let!(:quotes) {create_list(:quote, size)}

  before { get '/quotes' }

  it 'returns all quotes' do
    expect(JSON.parse(response.body).size).to eq(size)
  end

  it 'returns status code 200 - :success' do
    expect(response).to have_http_status(:success)
  end

end
