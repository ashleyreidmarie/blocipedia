class Page < ActiveRecord::Base
  belongs_to :wiki
  
  before_save { self.title[0] = self.title[0].upcase if self.title}
  
  #Scopes
  default_scope { order('title') } 
  
  scope :not_private, ->{self.joins(:wiki).where('wikis.private = ?', false)}
  scope :is_private, ->{self.joins(:wiki).where('wikis.private = ?', true)}
  scope :wiki_owned_by, ->(user){self.joins(:wiki).where('wikis.user_id = ?', user.id)}
  scope :visible_to, ->(user){self.joins(:wiki).where('wikis.user_id =? OR wikis.private = ?', user.id, false)}
  
  #Validations
  validates :title, 
    length: { minimum: 3 },
    presence: true,
    format: {message: 'Cannot contain those special characters', without: /[@\\\/+*?\[^\]$(){}=!<>|]/}
    
  validates :body, length: {minimum: 5}, presence: true
  validates :wiki, presence: true
end
