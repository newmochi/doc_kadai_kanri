json.array!(@users) do |user|
  json.extract! user, :id, :uname, :upass, :uemail, :unote, :unotedetail
  json.url user_url(user, format: :json)
end
