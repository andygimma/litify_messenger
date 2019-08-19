class ChatsController < ApplicationController
  include MessageHelpers
  before_action :require_login
  def new
    @chat = Chat.new
    @users = User.all_except(current_user).select(:id, :email)
  end

  def create
    respond_to do |format|
      if create_message(chat_params, current_user, params, 'chat')
        format.html { redirect_to show_chat_thread_path(@chat.message_thread), notice: 'Chat was successfully created.' }
        format.json { render :show, status: :created, location: @chat }
      else
        @users = User.all_except(current_user).select(:id, :email)
        format.html { render :new }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_reply
    @message_thread_id = Chat.find(params[:id]).message_thread_id
    @chat = Chat.new
    @sent_users = MessageThreadUser.where(message_thread_id: @message_thread_id).pluck(:user_id)
    @users = User.all_except(current_user).select(:id, :email)
  end

  private

  def chat_params
    params.require(:chat).permit(:body)
  end

  def create_message(email_params, current_user, params, message_type)
    ActiveRecord::Base.transaction do
      message_thread_id = get_or_create_message_thread(params["chat"]["message_thread_id"], current_user)
      @message = create_chat(chat_params, current_user)
      create_message_thread_users(params, current_user, message_thread_id, @message.id, message_type)
      if @message.valid? == false
        raise ActiveRecord::Rollback
      end
    end
    @message.valid?
  end

  def create_chat(chat_params, current_user)
    ActiveRecord::Base.transaction do
      @chat = Chat.new(chat_params)
      @chat.user = current_user
      @chat.message_thread_id = @message_thread_id
      @chat.save
      @chat
    end
  end
end
