class Rsvp < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :course
end
