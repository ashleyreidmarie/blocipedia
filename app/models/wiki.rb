class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy
  
  validates :name, presence: true
end
