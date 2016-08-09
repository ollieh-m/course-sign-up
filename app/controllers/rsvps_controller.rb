class RsvpsController < ApplicationController
  
  include Emails
  
  def new
    @course = Course.find(params[:course_id])
    @attendee = Attendee.new
  end
  
  def create
    rsvp = Rsvp.build_with(attendee_params,params[:course_id])
    if rsvp.save
      email_rsvp_confirmation_token(rsvp)
      redirect_to courses_path
    else
      flash[:errors] = rsvp.errors.full_messages
      redirect_to courses_path
    end
  end
  
  private
  
  def attendee_params
    params.require(:attendee).permit(:email,:date_of_birth)
  end
  
end