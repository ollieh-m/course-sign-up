module RsvpValidations
  
  def validate_attendee
    unless attendee.valid?
      attendee.errors.full_messages.each{ |attendee_error| add_error(attendee_error) }
    end
  end

end