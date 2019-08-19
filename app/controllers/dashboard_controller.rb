class DashboardController < ApplicationController
  include MessageHelpers
  before_action :require_login

  def home
    @emails = Email.where(id: MessageThreadUser
                .user_dashboard_list(current_user, 'email')
                .pluck(:message_id)
              )
              .order(created_at: :desc)
              .paginate(page: params[:page], per_page: 10)
  end

  def chat
  end
end
