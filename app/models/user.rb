class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, :lockables
  
  before_save { self.username[0] = self.username[0].upcase }
  # before_save { names = self.username.split(' ')
  #               names.first.capitalize!
  #               self.username = names.join(' ') }
  
  validates :username, length: { minimum: 2, maximum: 35 }, presence: true, uniqueness: true
  
end
