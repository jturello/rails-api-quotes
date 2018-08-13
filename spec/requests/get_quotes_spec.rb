require 'rails_helper' 

describe "get quotes request", :type => :request do
  let!(:size) {2} 
  let!(:quotes) {create_list(:quote, size)}
  let!(:valid_id) {quotes.first.id}
  let!(:invalid_id) {quotes.first.id + quotes.last.id}

  context 'when getting all quotes' do
    context 'with valid input' do
      before { get '/api/v1/quotes' }

      it 'returns all quotes' do
        expect(JSON.parse(response.body).size).to eq(size)
      end

      it 'returns status code 200 - :success' do
         expect(response).to have_http_status(:success)
      end

      it "returns response with content type 'application/json'" do
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  context 'when getting one quote' do
    context 'with valid input' do
      before do
	get "/api/v1/quotes/#{valid_id}"
      end

      it 'returns the correct quote' do
        expect(JSON.parse(response.body)['id']).to eq(valid_id) 
      end

      it 'returns status 200 - :success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid input' do
      context 'when requested id does not exist' do
	before do
	  get "/api/v1/quotes/#{invalid_id}"
	end

	it 'returns status 404 - :not_found' do
	  expect(response).to have_http_status(:not_found)
	end
	
	it 'returns RecordNotFound error' do
	  expect(JSON.parse(response.body)['message']).to include("Couldn't find Quote with 'id'=#{invalid_id}")
	end     
      end
    end
  end
end
