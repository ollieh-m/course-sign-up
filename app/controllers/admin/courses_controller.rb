class Admin::CoursesController < ApplicationController

  include AdminAuthentication
  
  before_filter :check_admin_is_signed_in

  def index
    @new_course = Course.new
  end
  
  def create
    course = Course.new(course_params)
    if course.save
      redirect_to admin_courses_path
    end
  end

  private
  
  def course_params
    params.require(:course).permit(:name,:description,:start,:end)
  end

end