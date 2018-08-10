require 'rails_helper'

describe "put quote request" do

  let!(:quote) { create(:quote) }
  let!(:id) { quote.id }

  before do
    put "/quotes/#{id}", params: { author: 'updated author', content: 'updated content' }
  end

  it 'returns the updated author' do
    expect(JSON.parse(response.body)['author']).to eq('updated author')
  end

  it 'returns the updated content' do
    expect(JSON.parse(response.body)['content']).to eq('updated content')
  end
end

