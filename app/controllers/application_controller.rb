class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  # def user_for_paper_trail
  #   logged_in? ? current_member.id : 'Public user'  # or whatever
  # end
end
