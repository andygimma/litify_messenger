class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
    @users = User.all.select(:id, :email)
  end

  # GET /emails/1/edit
  def edit
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

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:subject, :body, :users)
    end

    def user_ids_from_params(params)
      params["email"]["users"].reject { |u| u.empty? }
    end

    def create_thread_and_email(email_params, current_user, params)
      user_ids = user_ids_from_params(params)
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
