class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { data: "Authenticated." }
  end
end
