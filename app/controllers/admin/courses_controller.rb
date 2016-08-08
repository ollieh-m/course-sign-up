class Admin::CoursesController < ApplicationController

  include AdminAuthentication
  before_filter :check_admin_is_signed_in

  def index
    @new_course = Course.new
    @courses = Course.all
  end
  
  def show
    @course = Course.find(params[:id])
  end
  
  def create
    course = Course.new(course_params)
    if course.save
      flash[:notices] = ["#{course.name} successfully posted"]
    else
      flash[:errors] = course.errors.full_messages
    end
    redirect_to admin_courses_path
  end

  private
  
  def course_params
    params.require(:course).permit(:name,:description,:start,:end)
  end

end