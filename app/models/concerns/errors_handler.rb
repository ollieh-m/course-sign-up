module ErrorsHandler
  
  def add_error(message)
    errors[:base] << message
  end

end