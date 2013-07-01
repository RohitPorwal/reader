class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :user_is_the_one_who_is_logged_in
  
  include SentientController
  include ActionView::Helpers::DateHelper
  
  private
  
  def user_is_the_one_who_is_logged_in
    if current_user.present?
      @user = current_user
      @history_count = @user.entries_count('h' , nil)
      @star_count = @user.entries_count('s' , nil)
      @to_read_count = @user.entries_count('r', nil)
    end
  end
   
end
