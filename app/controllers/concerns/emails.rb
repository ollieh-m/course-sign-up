module Emails
  
  def link(type:,object:,token:)
    send("#{type}_url", id: object.id, token: token)
  end
  
  def email_rsvp_confirmation_token(rsvp)
    token = TokenGenerator.new(rsvp).call(:confirmation)
    rsvp_confirmation_link = link(type: :rsvp_confirmation, object: rsvp, token: token)
    Mailer.new(CourseMailerParams.new, MessageParams.new(type: :rsvp_confirmation, link: rsvp_confirmation_link, recipient: rsvp.attendee)).send
  end
  
end