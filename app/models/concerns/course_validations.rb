module CourseValidations
  
  def validated(course_params)
    validate_name(course_params[:name])
    validate_dates(course_params[:start],course_params[:end])
    valid_status
  end
  
  def validate_name(name)
    add_error('Course cannot be posted without a name') if name == ''
  end
  
  def validate_dates(start_date,end_date)
    if validate_dates_present(start_date,end_date)
      validate_dates_order(start_date,end_date)
    end
  end
  
  private
  
  def validate_dates_present(start_date,end_date)
    add_error('Course needs a start date') if start_date == ''
    add_error('Course needs an end date') if end_date == ''
    start_date != '' && end_date != ''
  end
  
  def validate_dates_order(start_date,end_date)
    add_error('Course must start in the future') if parse_date(start_date) < DateTime.now
    add_error('Course must end after it starts!') if parse_date(end_date) <= parse_date(start_date) 
  end
  
  def parse_date(date)
    DateTime.strptime(date,'%Y-%m-%d')
  end
  
end