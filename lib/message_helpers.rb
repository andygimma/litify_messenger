module MessageHelpers
  def get_or_create_message_thread(existing_id, current_user)
    ActiveRecord::Base.transaction do
      @message_thread_id = nil
      if existing_id != ""
        @message_thread_id = existing_id.to_i
      else
        @message_thread = MessageThread.new
        @message_thread.user = current_user
        @message_thread.save
        @message_thread_id = @message_thread.id
      end
      @message_thread_id
    end
  end

  def create_message_thread_users(params, current_user, message_thread_id, message_id, message_type)
    user_ids = user_ids_from_params(params, current_user, message_type)
    ActiveRecord::Base.transaction do
      user_ids.each do |user_id|
        @message_thread_user = MessageThreadUser.new(
                                user_id: user_id,
                                message_thread_id: message_thread_id,
                                message_type: message_type,
                                message_id: message_id
                              )
        @message_thread_user.save
      end
    end
  end

  def user_ids_from_params(params, current_user, message_type)
    params["#{message_type}"]["users"].push(current_user.id.to_s)
    params["#{message_type}"]["users"].reject { |u| u.empty? }
  end
end