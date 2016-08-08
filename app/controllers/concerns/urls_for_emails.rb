module UrlsForEmails
  
  def link(type:,object:,token:)
    send("#{type}_url", id: object.id, token: token)
  end
  
end