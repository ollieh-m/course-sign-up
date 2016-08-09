require 'rest-client'

class Mailer
  
  def initialize(coursemailerparams,messageparams)
    @url = coursemailerparams.url
    @from = coursemailerparams.from
    @to = messageparams.to
    @subject = messageparams.subject
    @text = messageparams.text
  end
  
  def send
    RestClient.post(@url,
                    :from => @from,
                    :to => @to,
                    :subject => @subject,
                    :text => @text)
  end
  
end