json.extract! user, :id, :name, :username, :email, :profile_page, :created_at, :updated_at
json.url user_url(user, format: :json)
