class MessageThreadsController < ApplicationController
  before_action :require_login

  def show
    # TODO ensure permission
    @emails = Email
                .where(message_thread_id: params[:id])
                .order(created_at: :desc)
                .paginate(page: params[:page], per_page: 10)
  end
end
