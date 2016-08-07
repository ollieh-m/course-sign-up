class Course < ActiveRecord::Base
  
  include CourseValidations
  include ErrorsHandler
  
  has_many :rsvps
  has_many :attendees, through: :rsvps
  
  def unconfirmed_attendees
    rsvps.where(status: 'unconfirmed').map do |rsvp|
      rsvp.attendee
    end
  end
    
  def validate_then_save(course_params)
    save if validated(course_params)
  end
  
end
