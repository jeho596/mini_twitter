json.users do
    json.array! @users do |user|
        json.username user.username
        json.full_name user.full_name
    end
end