class Mud < ActiveRecord::Base
    has_many :wikis, dependent: :destroy
    
    #Mud scopes
    default_scope { order('name') } 
    scope :approved, ->{where(approved: true)}
    scope :unapproved, ->{where(approved: false)}
    
    #Mud validations
    validates :name, 
      length: { minimum: 2, maximum: 100 }, 
      presence: true, 
      uniqueness: true, 
      format: {message: 'cannot contain special characters', without: /[@]/}
      
    # validate do
    #     URI::parse(self.url)
    # rescue URI::InvalidURIError
    #     errors.add(:url, "must be valid url")
    # end
end