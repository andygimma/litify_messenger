class MessageThreadsController < ApplicationController
  before_action :require_login

  def show
    # TODO ensure permission
    # @emails = MessageThread.find(params[:id])
    #             .emails
    #             .paginate(page: params[:page], per_page: 10)

    @message_threads = MessageThreadUser
          .where(message_thread_id: params[:id], user_id: current_user.id)
          .preload(:email)
          .paginate(page: params[:page], per_page: 10)
  end
end
