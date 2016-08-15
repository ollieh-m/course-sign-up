class Rsvp < ActiveRecord::Base
  
  include RsvpValidations
  include ErrorsHandler
  include AuthenticationHandler
  
  validates :attendee, uniqueness: {scope: :course}
  validate { validate_attendee }
  
  belongs_to :attendee
  belongs_to :course
  
  def self.build_with(attendee_params,course_id)
    attendee = Attendee.new(attendee_params)
    course = Course.find(course_id)
    attendee.rsvps.build(course: course, status: 'unconfirmed')
  end
  
end
