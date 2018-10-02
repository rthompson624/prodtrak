class Session < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :session_hash
  validates_presence_of :login
  
end
