class Page < ActiveRecord::Base
  belongs_to :wiki
  
  before_save { self.title[0] = self.title[0].upcase if self.title}
  
  #Page validations
  validates :title, 
    length: { minimum: 3 },
    presence: true,
    format: {message: 'Cannot contain those special characters', without: /[@\\\/+*?\[^\]$(){}=!<>|]/}
    
  validates :body, length: {minimum: 5}, presence: true
  validates :wiki, presence: true
end
