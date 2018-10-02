class Department < ActiveRecord::Base
  has_many :punchlists
  
  validates_presence_of :name
  
end
