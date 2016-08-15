class RsvpConfirmationsController < ApplicationController
  
  def create
    rsvp = Rsvp.find(confirmation_params[:id])
    if rsvp && rsvp.authenticate(:confirmation_token,confirmation_params[:token])
      rsvp.update(status: 'confirmed')
    else
      flash[:errors] = ['Confirmation failed']
    end
    redirect_to courses_path
  end
  
  private
  
  def confirmation_params
    params.permit(:id,:token)
  end
  
end