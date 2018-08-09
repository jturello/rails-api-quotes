require 'rails_helper' 
describe "returns all quotes", :type => :request do
  let!(:size) {4} 
  let!(:quotes) {create_list(:quote, size)}

  before { get '/quotes' }

  it 'returns all quotes' do
    expect(JSON.parse(response.body).size).to eq(size)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

end
