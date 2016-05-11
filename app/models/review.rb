class Review < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  validates :body, presence: true, length: {minimum: 20, maximum: 5000}
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
  
  default_scope -> { order(updated_at: :desc) }
end