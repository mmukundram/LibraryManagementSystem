json.array!(@users) do |user|
  json.extract! user, :id, :email, :name, :password, :address, :phone, :admin, :removable, :privilege
  json.url user_url(user, format: :json)
end
