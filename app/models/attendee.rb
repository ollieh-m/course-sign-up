class Attendee < ActiveRecord::Base
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: 'You must enter a valid email' }
  validates :date_of_birth, presence: true
    
  has_many :rsvps
  has_many :courses, through: :rsvps
  
end
