require 'bcrypt'

class TokenGenerator
  
  include BCrypt
  
  def initialize(object)
    @object = object
  end
  
  def call(token_name)
    name = "#{token_name}_token_hash".to_sym
    SecureRandom.urlsafe_base64.tap do |token|
      @object.update(name => BCrypt::Password.create(token))
    end
  end
  
end