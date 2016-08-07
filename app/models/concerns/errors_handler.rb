module ErrorsHandler
  
  def add_error(message)
    @custom_errors.nil? ? @custom_errors = [message] : @custom_errors << message
    @valid_status = false
  end
  
  def custom_errors
    @custom_errors ||= []
  end
  
  def valid_status
    @valid_status.nil? ? true : @valid_status
  end
  
end