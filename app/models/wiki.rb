class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :mud
  has_many :pages, dependent: :destroy
  
  validates :name, length: { minimum: 3 }, presence: true, uniqueness: true
  validates :description, length: {minimum: 5}, presence: true
  validates :mud, presence: true
  validates :user, presence: true
    
end
