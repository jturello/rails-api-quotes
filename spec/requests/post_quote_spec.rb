require 'rails_helper' 

describe "post a quote route", type: :request do
  
  before do
    post '/quotes', params: { author: 'test author', content: 'test content' }
  end

  it 'returns the author name' do
    expect(JSON.parse(response.body)['author']).to eq('test author') 
  end

  it 'returns the content' do
    expect(JSON.parse(response.body)['content']).to eq('test content')
  end
end
