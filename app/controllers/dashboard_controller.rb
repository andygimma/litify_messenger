class DashboardController < ApplicationController
  before_action :require_login

  def home
    @threads = MessageThreadUser
                .select('DISTINCT ON ("message_thread_id") *')
                .where(user_id: current_user.id)
                .paginate(page: params[:page], per_page: 10)
  end
end
