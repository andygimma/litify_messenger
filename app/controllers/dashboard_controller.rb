class DashboardController < ApplicationController
  before_action :require_login

  def home
    @threads = MessageThread
                .where(user_id: current_user.id)
                .order(id: :desc)                
                .preload(:emails)
                .paginate(page: params[:page], per_page: 10)
  end
end
