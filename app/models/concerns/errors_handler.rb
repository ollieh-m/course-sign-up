module ErrorsHandler
  
  def add_error(message)
    @errors.nil? ? @errors = [message] : @errors << message
    @valid_status = false
  end
  
  def errors
    @errors ||= []
  end
  
  def valid_status
    @valid_status.nil? ? true : @valid_status
  end
  
end