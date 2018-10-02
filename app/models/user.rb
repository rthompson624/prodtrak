class User < ActiveRecord::Base
  has_many :sessions
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user
  validates_presence_of :password  
  validates_presence_of :role  
  
end
