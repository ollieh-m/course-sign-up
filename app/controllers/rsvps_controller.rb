class RsvpsController < ApplicationController
  
  def new
    @course = Course.find(params[:course_id])
    @attendee = Attendee.new
  end
  
  def create
    attendee = Attendee.new(attendee_params)
    course = Course.find(params[:course_id])
    attendee.rsvps.build(course: course, status: 'Unconfirmed')
    attendee.save
    p Rsvp.all
    p attendee.rsvps
    p course.rsvps
    p attendee.courses
    p course.attendees
  end
  
  private
  
  def attendee_params
    params.require(:attendee).permit(:email,:date_of_birth)
  end
  
end