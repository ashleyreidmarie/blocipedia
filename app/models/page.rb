class Page < ActiveRecord::Base
  belongs_to :wiki
  
  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: {minimum: 5}, presence: true
  validates :wiki, presence: true
end
