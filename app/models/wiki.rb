class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :mud
  has_many :pages, dependent: :destroy
  
  before_save { self.name[0] = self.name[0].upcase if self.name}
  
  #Scopes
  default_scope { order('name') } 
  # scope :public_to, ->(user){where('private = ? OR user_id = ?', false, user.id)} - added to WikiPolicy
  # scope :public_to, ->(user){where(public: true).or(where(user: user))} - Rails 5

  
  #Validations
  validates :name, 
    length: { minimum: 3 }, 
    presence: true, 
    uniqueness: true,
    format: {message: 'Cannot contain those special characters', without: /[@\\\/+*?\[^\]$(){}=!<>|]/}
    
  validates :description, length: {minimum: 5}, presence: true
  validates :mud, presence: true
  validates :user, presence: true
    
end
