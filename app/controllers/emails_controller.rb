class EmailsController < ApplicationController
  before_action :require_login

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

  # POST /emails
  # POST /emails.json
  def create
    respond_to do |format|
      if create_thread_and_email(email_params, current_user, params)
        format.html { redirect_to @email, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        # TODO remove Thread from errors
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def email_params
      params.require(:email).permit(:subject, :body, :users)
    end

    def user_ids_from_params(params, current_user)
      params["email"]["users"].push(current_user.id.to_s)
      params["email"]["users"].reject { |u| u.empty? }
    end

    def create_thread_and_email(email_params, current_user, params)
      user_ids = user_ids_from_params(params, current_user)
      ActiveRecord::Base.transaction do
        @message_thread = MessageThread.new
        @message_thread.user = current_user
        @message_thread.save

        user_ids.each do |user_id|
          @message_thread_user = MessageThreadUser.new(user_id: user_id, message_thread_id: @message_thread.id)
          @message_thread_user.save
        end

        @email = Email.new(email_params)
        @email.user = current_user
        @email.message_thread = @message_thread
        @email.save
        
        if @email.valid? == false
          raise ActiveRecord::Rollback
        end
      end
      @email.valid?
    end
end
