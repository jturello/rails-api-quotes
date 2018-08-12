require 'rails_helper' 

describe "post request to add quote", type: :request do
  
  context 'with valid input' do
    before do
      post '/api/v1/quotes', params: { author: 'test author', content: 'test content' }
    end
    
    it "returns the added author name" do
      expect(JSON.parse(response.body)['author']).to eq('test author') 
    end

    it 'returns the added content' do
      expect(JSON.parse(response.body)['content']).to eq('test content')
    end

    it 'returns status code 200 - :success' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'with invalid input' do
    context 'when Author is blank' do
      before do
        post '/api/v1/quotes', params: { author: '', content: 'test content' }
      end
      
      it 'returns RecordInvalid error when input Author is blank' do
	expect(JSON.parse(response.body)['message']).to include("Validation failed: Author can't be blank")
      end    
      
      it 'returns status 422 - :unprocessable_entity' do
	expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    
    context 'when Content is blank' do
      before do
        post '/api/v1/quotes', params: { author: 'test author', content: '' }
      end
    
      it 'returns RecordInvalid error when input Content is blank' do
	expect(JSON.parse(response.body)['message']).to include("Validation failed: Content can't be blank")
      end

      it 'returns status 422 - :unprocessable_entity' do
	expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
