class EmailsController < ApplicationController
  before_action :require_login
  # before_action :require_reply_permission, only: [:new_reply]

  # GET /emails/1
  # GET /emails/1.json
  def show
    @email = Email.find(params[:id])
  end

  # GET /emails/new
  def new
    @email = Email.new
    @users = User.all_except(current_user).select(:id, :email)
  end

  def new_reply
    # ensure that we can add to this thread
    @message_thread_id = Email.find(params[:id]).message_thread_id
    @email = Email.new
    @sent_users = MessageThreadUser.where(message_thread_id: @message_thread_id).pluck(:user_id)
    @users = User.all_except(current_user).select(:id, :email)
  end

  # POST /emails
  # POST /emails.json
  def create
    respond_to do |format|
      if create_thread_and_email(email_params, current_user, params)
        format.html { redirect_to @email, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        @users = User.all_except(current_user).select(:id, :email)
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def email_params
      params.require(:email).permit(:subject, :body)
    end

    def user_ids_from_params(params, current_user)
      params["email"]["users"].push(current_user.id.to_s)
      params["email"]["users"].reject { |u| u.empty? }
    end

    # def require_reply_permission
    #   user_id = current_user.id
    #   message_thread_id = Email.find(params[:id]).message_thread_id
    #   MessageThreadUser
    #     .where(
    #       user_id: user_id,
    #       message_thread_id: message_thread_id)
    #     .count > 0
    # end

    def create_thread_and_email(email_params, current_user, params)
      user_ids = user_ids_from_params(params, current_user)
      ActiveRecord::Base.transaction do
        # TODO make each of these blocks a function
        @message_thread_id = nil
        if params["email"]["message_thread_id"] != ""
          @message_thread_id = params["email"]["message_thread_id"].to_i
        else
          @message_thread = MessageThread.new
          @message_thread.user = current_user
          @message_thread.save
          @message_thread_id = @message_thread.id
        end

        @email = Email.new(email_params)
        @email.user = current_user
        @email.message_thread_id = @message_thread_id
        @email.save
        user_ids.each do |user_id|
          @message_thread_user = MessageThreadUser.new(user_id: user_id, message_thread_id: @message_thread_id, email_id: @email.id)
          @message_thread_user.save
        end
        if @email.valid? == false
          raise ActiveRecord::Rollback
        end
      end
      @email.valid?
    end
end
