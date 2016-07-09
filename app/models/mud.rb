class Mud < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  
  before_save { self.name[0] = self.name[0].upcase if self.name}
  
  #Mud scopes
  default_scope { order('name') } 
  scope :approved, ->{where(approved: true)}
  scope :unapproved, ->{where(approved: false)}
  
  #Mud validations
  validates :name, 
    length: { minimum: 2, maximum: 100 }, 
    presence: true, 
    uniqueness: true, 
    format: {message: 'cannot contain special characters', without: /[@\\\/+*?\[^\]$(){}=!<>|:]/}
    
  validates :url, presence: true, uniqueness: true, :url => true
end