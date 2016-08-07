class Rsvp < ActiveRecord::Base
  
  validates :attendee, uniqueness: {scope: :course}
  
  belongs_to :attendee
  belongs_to :course
  
  def self.build_with(attendee_params,course_id)
    attendee = Attendee.new(attendee_params)
    course = Course.find(course_id)
    attendee.rsvps.build(course: course, status: 'unconfirmed')
  end
  
end
