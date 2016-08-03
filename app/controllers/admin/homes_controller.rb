class Admin::HomesController < ApplicationController

  include AdminAuthentication
  before_filter :check_admin_is_signed_in
  
  def show
  end

end