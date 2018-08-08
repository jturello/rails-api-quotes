require 'rails_helper'

describe Quote, type: :model do

  it { should validate_presence_of :content }
  it { should validate_presence_of :author }
end
