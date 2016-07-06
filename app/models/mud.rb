class Mud < ActiveRecord::Base
    has_many :wikis, dependent: :destroy
    
    scope :approved, ->{where(approved: true)}
    scope :unapproved, ->{where(approved: false)}
    
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