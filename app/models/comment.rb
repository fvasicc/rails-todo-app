class Comment < ApplicationRecord
  belongs_to :todo
  validates :content, presence: true, length: { maximum: 500 }
end
