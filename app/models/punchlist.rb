class Punchlist < ActiveRecord::Base
  belongs_to :box
  belongs_to :department
  
  validates_presence_of :description
  
end
