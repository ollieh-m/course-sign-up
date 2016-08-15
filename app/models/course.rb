class Course < ActiveRecord::Base
  
  include CourseValidations
  include ErrorsHandler
  
  validates :name, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validate { validate_dates_order }
  
  has_many :rsvps
  has_many :attendees, through: :rsvps
  
  def unconfirmed_attendees
    attendees_by_status('unconfirmed')
  end
  
  def confirmed_attendees
    attendees_by_status('confirmed')
  end
  
  private
  
  def attendees_by_status(status)
    rsvps.where(status: status).map do |rsvp|
      rsvp.attendee
    end
  end
  
end
