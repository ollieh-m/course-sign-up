module RsvpValidations

  def validated
    validate_attendee
    validate_self
    valid_status
  end
  
  private
  
  def validate_attendee
    unless attendee.valid?
      attendee.errors.full_messages.each{ |rails_error| add_error(rails_error) }
    end
  end
  
  def validate_self
    unless valid?
      errors.full_messages.each{ |rails_error| add_error(rails_error) }
    end
  end

end