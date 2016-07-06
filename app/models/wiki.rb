class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :mud
  has_many :pages, dependent: :destroy
  
  validates :name, length: { minimum: 3 }, presence: true
  validates :user, presence: true
  validates :description, length: {minimum: 5}, presence: true
  validates :mud, presence: true
end
