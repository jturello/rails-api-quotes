require 'rails_helper'

describe "put/update request" do

  let!(:quote) { create(:quote) }
  let!(:id) { quote.id }

  context 'with valid input' do
    before do
      put "/api/v1/quotes/#{id}", params: { author: 'updated author', content: 'updated content' }
    end

    it 'returns the updated author' do
      expect(json_response[:author]).to eq('updated author')
    end

    it 'returns the updated content' do
      expect(json_response[:content]).to eq('updated content')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'with invalid input' do
    context 'when author is blank' do
      before do
	put "/api/v1/quotes/#{id}", params: { author: '', content: 'updated content' }
      end

      it 'returns RecordInvalid error' do
	expect(json_response[:message]).to include("Validation failed: Author can't be blank")
      end    

      it 'returns status 422 - :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when content is blank' do
      before do
	put "/api/v1/quotes/#{id}", params: { author: 'Italo Calvino', content: '' }
      end
    
      it 'returns RecordInvalid error' do
	expect(json_response[:message]).to include("Validation failed: Content can't be blank")
      end

      it 'returns status 422 - :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    
    context "when quote id not in database" do
      let!(:request_author) { 'updated author' }

      before do
	put "/api/v1/quotes/#{id+1}", params: { author: request_author, content: 'updated content' }
      end

      it 'does not update/save request' do
	get "/api/v1/quotes"
	expect(json_response.size).to eq(1)
	expect(json_response.first[:author]).not_to eq(request_author)
      end

      it 'returns status 404 - :not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns RecordNotFound error' do
	expect(json_response[:message]).to include("Couldn't find Quote with 'id'=#{id+1}")
      end     
    end
  end
end

