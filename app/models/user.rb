class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable, :lockables
  
  before_save { self.username[0] = self.username[0].upcase }
  
  validates :username, length: { minimum: 2, maximum: 35 }, presence: true, uniqueness: true, format: {message: 'cannot contain special characters', without: /[@]/}
  
  attr_accessor :username_or_email
  
  def self.find_for_database_authentication(warden_conditions)
    username_or_email = warden_conditions[:username_or_email]
    find_by('username = ? OR email = ?', username_or_email, username_or_email)
  end
  
end