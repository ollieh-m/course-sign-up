class Rsvp < ActiveRecord::Base
  
  include ErrorsHandler
  include RsvpValidations
  
  validates :attendee, uniqueness: {scope: :course}
  
  belongs_to :attendee
  belongs_to :course
  
  def self.build_with(attendee_params,course_id)
    attendee = Attendee.new(attendee_params)
    course = Course.find(course_id)
    attendee.rsvps.build(course: course, status: 'unconfirmed')
  end
  
  def validate_then_save
    save if validated
  end
  
end
