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
    rsvps.where(status: 'unconfirmed').map do |rsvp|
      rsvp.attendee
    end
  end
  
end
