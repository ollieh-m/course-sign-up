class Course < ActiveRecord::Base
  
  include CourseValidations
  include ErrorsHandler
    
  def validate_then_save(course_params)
    save if validated(course_params)
  end
  
end
