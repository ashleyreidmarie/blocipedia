class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :mud
  has_many :pages, dependent: :destroy
  
  validates :name, length: { minimum: 5 }, presence: true
end
