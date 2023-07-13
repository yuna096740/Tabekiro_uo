class Room < ApplicationRecord
  has_many :entries,  dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :post
end
