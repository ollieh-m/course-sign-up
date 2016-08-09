class CourseMailerParams
  
  def url
    "https://api:#{ENV["MAILER_API"]}@api.mailgun.net/v3/#{ENV["MAILER_DOMAIN"]}/messages"
  end
  
  def from
    "Course admin <mailgun@#{ENV["MAILER_DOMAIN"]}>"
  end
  
end