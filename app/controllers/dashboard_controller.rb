class DashboardController < ApplicationController
  before_action :require_login

  def home
    @threads = MessageThreadUser
                .where(user_id: current_user.id)
                .order('message_thread_users.message_thread_id, created_at DESC')
                .select('DISTINCT ON ("message_thread_id") *')
                .paginate(page: params[:page], per_page: 10)
  end
end
