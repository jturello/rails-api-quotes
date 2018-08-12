require 'rails_helper'

describe "put request to update a quote" do

  let!(:quote) { create(:quote) }
  let!(:id) { quote.id }

  context 'with valid input' do
    before do
      put "/quotes/#{id}", params: { author: 'updated author', content: 'updated content' }
    end

    it 'returns the updated author' do
      expect(JSON.parse(response.body)['author']).to eq('updated author')
    end

    it 'returns the updated content' do
      expect(JSON.parse(response.body)['content']).to eq('updated content')
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'with invalid input' do
    context 'when author is blank' do
      before do
	put "/quotes/#{id}", params: { author: '', content: 'updated content' }
      end

      it 'returns RecordInvalid error when input Author is blank' do
	expect(JSON.parse(response.body)['message']).to include("Validation failed: Author can't be blank")
      end    

      it 'returns status 422 - :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when content is blank' do
      before do
	put "/quotes/#{id}", params: { author: 'Italo Calvino', content: '' }
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

