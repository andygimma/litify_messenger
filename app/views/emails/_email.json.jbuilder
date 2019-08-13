json.extract! email, :id, :user_id, :subject, :body, :read, :created_at, :updated_at
json.url email_url(email, format: :json)
