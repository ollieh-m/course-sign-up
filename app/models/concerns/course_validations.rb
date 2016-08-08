module CourseValidations
  
  def validate_dates_order
    if self.start.present? && self.end.present?
      add_error('Course must start in the future') if self.start < DateTime.now
      add_error('Course must end after it starts!') if self.end <= self.start
    end
  end
  
end