class Attendee < ActiveRecord::Base
    
    has_many :rsvps
    has_many :courses, through: :rsvps
    
end
