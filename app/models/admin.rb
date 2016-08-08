require 'bcrypt'

class Admin < ActiveRecord::Base
  
  include BCrypt
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  attr_accessor :password
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: 'You must enter a valid email' }
  validates :password, presence: true, confirmation: true
  
  def set_password_hash(new_password)
    password = BCrypt::Password.create(new_password)
    self.tap do |admin|
      admin.password_hash = password
    end
  end
  
  def authenticate(submitted_password)
    my_password = BCrypt::Password.new(self.password_hash)
    my_password == submitted_password
  end
  
end
