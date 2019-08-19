class EmailsController < ApplicationController
  include MessageHelpers
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
      if create_message(email_params, current_user, params, 'email')
        format.html { redirect_to @email.message_thread, notice: 'Email was successfully created.' }
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

    def create_message(email_params, current_user, params, message_type)
      ActiveRecord::Base.transaction do
        message_thread_id = get_or_create_message_thread(params["email"]["message_thread_id"], current_user)
        @message = create_email(email_params, current_user)
        create_message_thread_users(params, current_user, message_thread_id, @message.id, message_type)
        if @message.valid? == false
          raise ActiveRecord::Rollback
        end
      end
      @message.valid?
    end

    def create_email(email_params, current_user)
      ActiveRecord::Base.transaction do
        @email = Email.new(email_params)
        @email.user = current_user
        @email.message_thread_id = @message_thread_id
        @email.save
        @email
      end
    end
end
