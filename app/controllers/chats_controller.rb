class ChatsController < ApplicationController
  before_action :require_login
  def new
    @chat = Chat.new
    @users = User.all_except(current_user).select(:id, :email)
  end

  def create
  end
end
