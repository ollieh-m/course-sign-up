class RsvpsController < ApplicationController
  
  def new
    @course = Course.find(params[:course_id])
    @attendee = Attendee.new
  end
  
  def create
    rsvp = Rsvp.build_with(attendee_params,params[:course_id])
    if rsvp.save
      # rsvp.send_confirmation_token
      # rsvp_token = SecureRandom.urlsafe_base64
      #save digest of token in rsvp record
      #email link containing rsvp token and rsvp id to attendee's email address
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