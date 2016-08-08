class RsvpsController < ApplicationController
  
  include UrlsForEmails
  
  def new
    @course = Course.find(params[:course_id])
    @attendee = Attendee.new
  end
  
  def create
    rsvp = Rsvp.build_with(attendee_params,params[:course_id])
    if rsvp.save
      token = TokenGenerator.new(rsvp).call(:confirmation)
      Mailer.new.send_confirmation_token(to: rsvp.attendee, link: link(type: 'rsvp_confirmation', object: rsvp, token: token))
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