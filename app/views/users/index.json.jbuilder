json.array!(@users) do |user|
  json.extract! user, :id, :email, :name, :password, :address, :phone, :admins, :removable, :privilege
  json.url user_url(user, format: :json)
end
