class MessageParams
  
  def initialize(type:,link:,recipient:)
    @type = type
    @link = link
    @recipient = recipient
  end
  
  def to
    @recipient.email
  end
  
  def subject
    return "Confirm your place on the course" if @type == :rsvp_confirmation
  end
  
  def text
    "Please click this link to confirm your place on the course:\n#{@link}"
  end
  
end