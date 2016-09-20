json.extract! user, :id, :email, :name, :password, :address, :phone, :type, :removable, :privilege, :created_at, :updated_at
json.url user_url(user, format: :json)