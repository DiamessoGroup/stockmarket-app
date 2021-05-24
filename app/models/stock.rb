class Stock < ApplicationRecord
  belongs_to :user
  validates :ticker, presence: true, format: {without: /\s/}

end
