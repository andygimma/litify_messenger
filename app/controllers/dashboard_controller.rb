class DashboardController < ApplicationController
  before_action :require_login

  def home
    @threads = MessageThreadUser
                .user_dashboard_list(current_user)
                .paginate(page: params[:page], per_page: 10)
  end
end
