class Quote < ApplicationRecord

  validates :content, :author, presence: true
end
