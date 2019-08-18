class MessageThreadsController < ApplicationController
  before_action :require_login

  def show
    @emails = MessageThread.find(params[:id])
                .emails
                .paginate(page: params[:page], per_page: 10)

  end
end
