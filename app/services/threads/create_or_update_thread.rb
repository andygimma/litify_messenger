class CreateOrUpdateThread
  def initialize(current_user, email_params, thread_id)
    @current_user = current_user
    @email_params = email_params
    @thread_id = thread_id
  end

  def run
    if @thread_id = nil

    else

    end
  end

  def create_thread_and_email(email_params)
    ActiveRecord::Base.transaction do
      @thread = Thread.new
      @thread.save
      ActiveRecord::Base.transaction do
        @email = Email.new(email_params)
        @email.save
      end
      @email
    end
  end

  def update_thread_with_email(email_params)

  end
end