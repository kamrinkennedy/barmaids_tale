class Review < ApplicationRecord
    belongs_to :user
    belongs_to :recipe
    validates :content, :user_id, :recipe_id, presence: true
    validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
