class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :mud
  has_many :pages, dependent: :destroy
  
  before_save { self.name[0] = self.name[0].upcase if self.name}
  
  validates :name, 
    length: { minimum: 3 }, 
    presence: true, 
    uniqueness: true,
    format: {message: 'Cannot contain those special characters', without: /[@\\\/+*?\[^\]$(){}=!<>|]/}
    
  validates :description, length: {minimum: 5}, presence: true
  validates :mud, presence: true
  validates :user, presence: true
    
end
