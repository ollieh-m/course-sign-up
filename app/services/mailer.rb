require 'rest-client'

class Mailer
  
  def initialize
  end
  
  def send_confirmation_token(to:,link:)
    RestClient.post(api_url,
                    :from => from,
                    :to => to.email,
                    :subject => "Confirm your place on the course",
                    :text => link)
  end
  
  def from
    "Course admin <mailgun@#{ENV["MAILER_DOMAIN"]}>"
  end
  
  def api_url
    "https://api:#{ENV["MAILER_API"]}@api.mailgun.net/v3/#{ENV["MAILER_DOMAIN"]}/messages"
  end
  
end