class Mud < ActiveRecord::Base
    has_many :wikis
    
    scope :approved, ->{where(verified: true)}
    scope :unapproved, ->{where(verified: false)}
    
    # validate do
    #     URI::parse(self.url)
    # rescue URI::InvalidURIError
    #     errors.add(:url, "must be valid url")
    # end
end


# Mud.approved
# form_for Wiki.new do |f|
#   f.collection_select(:mud_id, Mud.approved, :id, :name)

# class MudsController
#       def create
#           mud = Mud.new(mud_params)
          
#         def mud_params
#             params.require(:mud).permit(:name, :url, :mud_id)