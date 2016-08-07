class Attendee < ActiveRecord::Base
  
  validates :email, presence: true
  validates :date_of_birth, presence: true
    
  has_many :rsvps
  has_many :courses, through: :rsvps
  
end
