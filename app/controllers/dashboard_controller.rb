class DashboardController < ApplicationController
  before_action :require_login

  def home
    # @my_message_thread_users = MessageThreadUser.where(user_id: current_user.id).threads.emails
    @emails = Email
                .where(message_thread_id:
                  MessageThreadUser
                    .where(user_id: current_user.id)
                    .pluck(:message_thread_id)
              ).paginate(page: params[:page], per_page: 1)
  end
end