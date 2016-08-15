module AuthenticationHandler
  
  def authenticate(type,submitted_token)
    stored_hash = self.send("#{type}_hash".to_sym)
    my_unhashed_token = BCrypt::Password.new(stored_hash)
    my_unhashed_token == submitted_token
  end
  
end